CREATE PROCEDURE [dbo].[DetComprobantesProveedores_TXComp]

@IdComprobanteProveedor int

AS

DECLARE @vector_X varchar(60),@vector_T varchar(60)
SET @vector_X='0001111111111111000000000000000000001133'
SET @vector_T='000414033354E331000000000000000000003G00'

SELECT
 DetCom.IdDetalleComprobanteProveedor,
 DetCom.IdComprobanteProveedor,
 DetCom.IdCuenta,
 DetCom.CodigoCuenta as [Cod. Cuenta],
 IsNull((Select Top 1 dc.NombreAnterior From DetalleCuentas dc Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>cp.FechaRecepcion Order By dc.FechaCambio),Cuentas.Descripcion) as [Cuenta],
 Obras.NumeroObra as [Obra],
 Substring(
	 Case When DetCom.AplicarIVA1='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje1)+'%  ' Else '' End + 
	 Case When DetCom.AplicarIVA2='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje2)+'%  ' Else '' End + 
	 Case When DetCom.AplicarIVA3='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje3)+'%  '	Else '' End + 
	 Case When DetCom.AplicarIVA4='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje4)+'%  '	Else '' End + 
	 Case When DetCom.AplicarIVA5='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje5)+'%  '	Else '' End +
	 Case When DetCom.AplicarIVA6='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje6)+'%  '	Else '' End +
	 Case When DetCom.AplicarIVA7='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje7)+'%  '	Else '' End +
	 Case When DetCom.AplicarIVA8='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje8)+'%  '	Else '' End +
	 Case When DetCom.AplicarIVA9='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje9)+'%  '	Else '' End +
	 Case When DetCom.AplicarIVA10='SI' Then Convert(varchar,DetCom.IVAComprasPorcentaje10)+'%  '	Else '' End ,1,100) as [IVA],
 IsNull(DetCom.ImporteIVA1,0) + IsNull(DetCom.ImporteIVA2,0) + IsNull(DetCom.ImporteIVA3,0) + IsNull(DetCom.ImporteIVA4,0) + IsNull(DetCom.ImporteIVA5,0) + 
	IsNull(DetCom.ImporteIVA6,0) + IsNull(DetCom.ImporteIVA7,0) + IsNull(DetCom.ImporteIVA8,0) + IsNull(DetCom.ImporteIVA9,0) + IsNull(DetCom.ImporteIVA10,0) as [Importe IVA],
 DetCom.Importe as [Importe],
 Case When IsNull(DetCom.Cantidad,0)<>0 Then DetCom.Importe/DetCom.Cantidad Else Null End as [Costo Unit.],
 Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,15) as [Remito],
 Recepciones.FechaRecepcion as [Fecha rec.],
 Articulos.Descripcion as [Articulo],
 DetCom.Cantidad as [Cantidad],
 Case When Pedidos.NumeroPedido is not null Then Pedidos.NumeroPedido
	Else (Select Top 1 Pedidos.NumeroPedido From Pedidos Where DetCom.IdPedido=Pedidos.IdPedido)
 End as [Pedido],
 DetPed.NumeroItem as [It.Ped],
 DetCom.IVAComprasPorcentaje1,
 DetCom.AplicarIVA1,
 DetCom.IVAComprasPorcentaje2,
 DetCom.AplicarIVA2,
 DetCom.IVAComprasPorcentaje3,
 DetCom.AplicarIVA3,
 DetCom.IVAComprasPorcentaje4,
 DetCom.AplicarIVA4,
 DetCom.IVAComprasPorcentaje5,
 DetCom.AplicarIVA5,
 DetCom.IVAComprasPorcentaje6,
 DetCom.AplicarIVA6,
 DetCom.IVAComprasPorcentaje7,
 DetCom.AplicarIVA7,
 DetCom.IVAComprasPorcentaje8,
 DetCom.AplicarIVA8,
 DetCom.IVAComprasPorcentaje9,
 DetCom.AplicarIVA9,
 DetCom.IVAComprasPorcentaje10,
 DetCom.AplicarIVA10,
 RubrosContables.Descripcion as [Rubro financiero],
 Case When IsNull(Cuentas.ImputarAPresupuestoDeObra,'')='SI' 
	Then IsNull(PresupuestoObrasNodos.Item+' ','') + IsNull(PresupuestoObrasNodos.Descripcion, Obras.Descripcion) 
	Else 'No coreesponde'
 End as [Etapa presupuesto de obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleComprobantesProveedores DetCom
LEFT OUTER JOIN ComprobantesProveedores cp ON DetCom.IdComprobanteProveedor = cp.IdComprobanteProveedor
LEFT OUTER JOIN Articulos ON DetCom.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Cuentas ON DetCom.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON DetCom.IdObra = Obras.IdObra
LEFT OUTER JOIN DetalleRecepciones DetRec ON DetCom.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido = IsNull(DetRec.IdDetallePedido,DetCom.IdDetallePedido)
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetCom.IdRubroContable
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo=DetCom.IdPresupuestoObrasNodo
WHERE DetCom.IdComprobanteProveedor = @IdComprobanteProveedor
ORDER BY DetCom.Item