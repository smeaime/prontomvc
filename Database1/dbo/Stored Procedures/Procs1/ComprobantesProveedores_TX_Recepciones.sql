CREATE PROCEDURE [dbo].[ComprobantesProveedores_TX_Recepciones]

@Desde datetime,
@Hasta datetime,
@IdObra int = Null,
@IdCuenta int = Null,
@IdArticulo int = Null,
@NumeroRemito int = Null,
@IdProveedor int = Null,
@IdRubroContable int = Null,
@NumeroPedido int = Null

AS

SET @IdObra=IsNull(@IdObra,-1)
SET @IdCuenta=IsNull(@IdCuenta,-1)
SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @NumeroRemito=IsNull(@NumeroRemito,-1)
SET @IdProveedor=IsNull(@IdProveedor,-1)
SET @IdRubroContable=IsNull(@IdRubroContable,-1)
SET @NumeroPedido=IsNull(@NumeroPedido,-1)

SELECT
 DetCP.IdDetalleComprobanteProveedor,
 cp.FechaComprobante as [Fecha], 
 cp.NumeroReferencia as [NumeroReferencia],
 tc.Descripcion as [TiposComprobante],
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
	When cp.IdCuenta is not null Then 'F.fijo' 
	When cp.IdCuentaOtros is not null Then 'Otros' 
	Else Null
 End as [Tipo],
 IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [CodigoProveedor], 
 IsNull(P1.RazonSocial,C1.Descripcion) as [ProveedorCuenta], 
 O1.NumeroObra as [Obra],
 Cuentas.Codigo as [CodigoCuenta],
 IsNull((Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>cp.FechaRecepcion 
	Order By dc.FechaCambio),Cuentas.Descripcion) as [Cuenta],
 O3.NumeroObra as [ObraCuenta],
 DetCP.Importe as [Importe],
 DetRec.CostoUnitario as [CostoUnitario],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+
			IsNull('/'+Convert(varchar,Recepciones.SubNumero),'') as [Recepcion],
 Recepciones.NumeroRecepcionAlmacen as [NumeroRecepcionAlmacen],
 Recepciones.FechaRecepcion as [FechaRecepcion],
 Articulos.Codigo as [CodigoArticulo],
 Articulos.Descripcion as [Articulo],
 IsNull(DetCP.Cantidad,DetRec.Cantidad) as [Cantidad],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 DetPed.NumeroItem as [NumeroItem],
 RubrosContables.Descripcion as [RubroFinanciero],
 Monedas.Abreviatura as [Moneda],
 DetCP.Importe*cp.CotizacionMoneda as [ImportePesos],
 cp.CotizacionMoneda as [CotizacionMoneda],
 cp.Observaciones as [Observaciones],
 cp1.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp1.NumeroComprobante1)))+Convert(varchar,cp1.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp1.NumeroComprobante2)))+Convert(varchar,cp1.NumeroComprobante2) as [ComprobanteImputado],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion]
FROM DetalleComprobantesProveedores DetCP
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores P1 ON P1.IdProveedor=cp.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON P2.IdProveedor=cp.IdProveedorEventual
LEFT OUTER JOIN Cuentas C1 ON C1.IdCuenta=IsNull(cp.IdCuenta,cp.IdCuentaOtros)
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
LEFT OUTER JOIN Obras O1 ON O1.IdObra=cp.IdObra
LEFT OUTER JOIN Obras O2 ON O2.IdObra=Cuentas.IdObra
LEFT OUTER JOIN Obras O3 ON O3.IdObra=DetCP.IdObra
LEFT OUTER JOIN DetalleRecepciones DetRec ON DetCP.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=DetRec.IdRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=IsNull(DetCP.IdDetallePedido,DetRec.IdDetallePedido)LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetPed.IdPedido
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=IsNull(DetCP.IdArticulo,DetRec.IdArticulo)
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = cp.IdMoneda
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetCP.IdRubroContable
LEFT OUTER JOIN ComprobantesProveedores cp1 ON cp1.IdComprobanteProveedor=cp.IdComprobanteImputado
LEFT OUTER JOIN Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE (cp.FechaRecepcion Between @Desde And @Hasta) and IsNull(cp.Confirmado,'')<>'NO' and 
	(@IdObra=-1 or @IdObra=IsNull(DetCP.IdObra,cp.IdObra)) and 
	(@IdCuenta=-1 or @IdCuenta=DetCP.IdCuenta) and 
	(@IdArticulo=-1 or @IdArticulo=Articulos.IdArticulo) and 
	(@NumeroRemito=-1 or @NumeroRemito=Recepciones.NumeroRecepcion2) and 
	(@IdProveedor=-1 or @IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)) and 
	(@IdRubroContable=-1 or @IdRubroContable=DetCP.IdRubroContable) and 
	(@NumeroPedido=-1 or @NumeroPedido=Pedidos.NumeroPedido)
ORDER BY cp.FechaComprobante, P1.RazonSocial, C1.Descripcion