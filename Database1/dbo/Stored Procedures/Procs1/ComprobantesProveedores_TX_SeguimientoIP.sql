CREATE  Procedure [dbo].[ComprobantesProveedores_TX_SeguimientoIP]

@FechaDesde datetime,
@FechaHasta datetime,
@IdObra int

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111111111111133'
SET @vector_T='0460355505555B55555E320255F00'

SELECT 
 dcp.IdDetalleComprobanteProveedor as [IdDetalleComprobanteProveedor], 
 Proveedores.RazonSocial as [Proveedor], 
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 TiposComprobante.DescripcionAB as [Tipo],
 cp.NumeroReferencia as [Nro.interno],
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha recep.], 
 cp.FechaVencimiento as [Fecha vto.], 
 cp.BienesOServicios as [B/S],
 cp.FechaPrestacionServicio as [Fecha serv.],
 dcp.CodigoCuenta as [Cod. Cuenta],
 IsNull((Select Top 1 dc.NombreAnterior From DetalleCuentas dc Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>cp.FechaRecepcion Order By dc.FechaCambio),Cuentas.Descripcion) as [Cuenta],
 Obras.NumeroObra as [Obra],
 Substring(
	 Case When dcp.AplicarIVA1='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje1)+'%  ' Else '' End + 
	 Case When dcp.AplicarIVA2='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje2)+'%  ' Else '' End + 
	 Case When dcp.AplicarIVA3='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje3)+'%  ' Else '' End + 
	 Case When dcp.AplicarIVA4='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje4)+'%  ' Else '' End + 
	 Case When dcp.AplicarIVA5='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje5)+'%  ' Else '' End +
	 Case When dcp.AplicarIVA6='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje6)+'%  ' Else '' End +
	 Case When dcp.AplicarIVA7='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje7)+'%  ' Else '' End +
	 Case When dcp.AplicarIVA8='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje8)+'%  ' Else '' End +
	 Case When dcp.AplicarIVA9='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje9)+'%  ' Else '' End +
	 Case When dcp.AplicarIVA10='SI' Then Convert(varchar,dcp.IVAComprasPorcentaje10)+'%  '	Else '' End ,1,100) as [IVA],
 (IsNull(dcp.ImporteIVA1,0) + IsNull(dcp.ImporteIVA2,0) + IsNull(dcp.ImporteIVA3,0) + IsNull(dcp.ImporteIVA4,0) + IsNull(dcp.ImporteIVA5,0) + 
	IsNull(dcp.ImporteIVA6,0) + IsNull(dcp.ImporteIVA7,0) + IsNull(dcp.ImporteIVA8,0) + IsNull(dcp.ImporteIVA9,0) + IsNull(dcp.ImporteIVA10,0)) * TiposComprobante.Coeficiente as [Importe IVA],
 dcp.Importe * TiposComprobante.Coeficiente as [Importe],
 Case When IsNull(dcp.Cantidad,0)<>0 Then dcp.Importe/dcp.Cantidad Else Null End * TiposComprobante.Coeficiente as [Costo Unit.],
 Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,15) as [Remito],
 Recepciones.FechaRecepcion as [Fecha rec.],
 Articulos.Descripcion as [Articulo],
 dcp.Cantidad as [Cantidad],
 Case When Pedidos.NumeroPedido is not null Then Pedidos.NumeroPedido Else (Select Top 1 Pedidos.NumeroPedido From Pedidos Where dcp.IdPedido=Pedidos.IdPedido) End as [Pedido],
 DetPed.NumeroItem as [It.Ped],
 Requerimientos.NumeroRequerimiento as [RM],
 rc1.Descripcion as [Rubro financiero],
 rc2.Descripcion as [Rubro contable],
 IsNull(PresupuestoObrasNodos.Item+' ','') + IsNull(PresupuestoObrasNodos.Descripcion, Obras.Descripcion) as [Etapa presupuesto de obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleComprobantesProveedores dcp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = dcp.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,cp.IdProveedorEventual) = Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Monedas ON cp.ReintegroIdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON dcp.IdObra = Obras.IdObra
LEFT OUTER JOIN Articulos ON dcp.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleRecepciones DetRec ON dcp.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido = IsNull(DetRec.IdDetallePedido,dcp.IdDetallePedido)
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetPed.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN RubrosContables rc1 ON rc1.IdRubroContable=dcp.IdRubroContable
LEFT OUTER JOIN RubrosContables rc2 ON rc2.IdRubroContable=Cuentas.IdRubroContable
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo=dcp.IdPresupuestoObrasNodo
WHERE IsNull(cp.Confirmado,'NO')<>'NO' and (cp.IdProveedor is not null or cp.IdProveedorEventual is not null )and 
		(cp.FechaRecepcion Between @FechaDesde And @FechaHasta) and (@IdObra=-1 or IsNull(dcp.IdObra,0)=@IdObra)
ORDER BY cp.FechaRecepcion, [Numero]
