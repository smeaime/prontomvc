CREATE PROCEDURE [dbo].[Articulos_TX_CostosImportacionAAsignar]

AS

SET NOCOUNT ON

DECLARE @IdMonedaPesos numeric(18,4),@IdMonedaDolar numeric(18,4)

SET @IdMonedaPesos=IsNull((Select Top 1 IdMoneda From Parametros Where IdParametro=1),0)
SET @IdMonedaDolar=IsNull((Select Top 1 IdMonedaDolar From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar8 
			(
			 IdPedido INTEGER,
			 ImporteRecepciones NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar8 
 SELECT
  DetPed.IdPedido,
  SUM(IsNull(DetRec.Cantidad,0) * IsNull(DetPed.Precio,0))
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion=Recepciones.IdRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 WHERE DetRec.IdDetallePedido is not null and IsNull(Recepciones.Anulada,'NO')<>'SI'
 GROUP BY DetPed.IdPedido

CREATE TABLE #Auxiliar9 
			(
			 IdDetallePedido INTEGER,
			 ImporteRecepcionesItem NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar9 
 SELECT
  DetRec.IdDetallePedido,
  SUM(IsNull(DetRec.Cantidad,0) * IsNull(DetPed.Precio,0))
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion=Recepciones.IdRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 WHERE DetRec.IdDetallePedido is not null and IsNull(Recepciones.Anulada,'NO')<>'SI'
 GROUP BY DetRec.IdDetallePedido

CREATE TABLE #Auxiliar1 
			(
			 IdDetallePedido INTEGER,
			 Articulo VARCHAR(300),
			 Pedido VARCHAR(12),
			 DatosPedido VARCHAR(110),
			 Cantidad NUMERIC(18,2),
			 Entregado NUMERIC(18, 2),
			 CostoPedido NUMERIC(18, 4),
			 CostoItemPedido NUMERIC(18, 4),
			 TotalPedido NUMERIC(18, 2),
			 TotalComprobantes NUMERIC(18, 2),
			 CostoAAsignar NUMERIC(18, 4),
			 CostoPedidoDolar NUMERIC(18, 4),
			 CostoItemPedidoDolar NUMERIC(18, 2),
			 TotalPedidoDolar NUMERIC(18, 2),
			 TotalComprobantesDolar NUMERIC(18, 2),
			 CostoAAsignarDolar NUMERIC(18, 4),
			 IdArticulo INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT
  DetPed.IdDetallePedido,
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' '+
	'[ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' '+
	'item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  DetPed.Cantidad,
  0,
  DetPed.Precio * IsNull(Pedidos.CotizacionMoneda,1),
  DetPed.Precio * IsNull(Pedidos.CotizacionMoneda,1) * DetPed.Cantidad,
  (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)-IsNull(Pedidos.TotalIva2,0)+IsNull(Pedidos.Bonificacion,0)) * IsNull(Pedidos.CotizacionMoneda,1),
  0,
  0,
  Case When Pedidos.IdMoneda=@IdMonedaDolar 
	Then DetPed.Precio
	Else 	Case When IsNull(Pedidos.CotizacionDolar,0)<>0 
			Then Round(DetPed.Precio * IsNull(Pedidos.CotizacionMoneda,1)  / Pedidos.CotizacionDolar,2)
			Else 0
		End
  End,
  Case When Pedidos.IdMoneda=@IdMonedaDolar 
	Then DetPed.Precio
	Else 	Case When IsNull(Pedidos.CotizacionDolar,0)<>0 
			Then Round(DetPed.Precio * IsNull(Pedidos.CotizacionMoneda,1) / Pedidos.CotizacionDolar,2)
			Else 0
		End
  End * DetPed.Cantidad,
  Case When Pedidos.IdMoneda=@IdMonedaDolar 
	Then IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)-
		IsNull(Pedidos.TotalIva2,0)+IsNull(Pedidos.Bonificacion,0)
	Else 	Case When IsNull(Pedidos.CotizacionDolar,0)<>0 
			Then Round((IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)-IsNull(Pedidos.TotalIva2,0)+IsNull(Pedidos.Bonificacion,0)) * IsNull(Pedidos.CotizacionMoneda,1) / Pedidos.CotizacionDolar,2)
			Else 0
		End
  End,
  0,
  0,
  DetPed.IdArticulo
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.PedidoExterior,'NO')='SI' and IsNull(DetPed.CostoAsignado,0)=0 and 
	IsNull(DetPed.Cumplido,'NO')<>'AN' and IsNull(Pedidos.Cumplido,'NO')<>'AN'

 UNION ALL

 SELECT
  DetPed.IdDetallePedido,
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' '+
	'[ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' '+
	'item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  0,
  0,
  0,
  0,
  0,
  DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente,
  0,
  0,
  0,
  0,
  Case When cp.IdMoneda=@IdMonedaDolar 
	Then DetCP.Importe
	Else 	Case When IsNull(cp.CotizacionDolar,0)<>0 
			Then Round(DetCP.Importe * IsNull(cp.CotizacionMoneda,1)  / cp.CotizacionDolar,2)
			Else 0
		End  End * TiposComprobante.Coeficiente,
  0,
  DetPed.IdArticulo
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN Pedidos ON DetCP.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN DetalleRecepciones DetRec ON DetCP.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE DetCP.IdPedido is not null and IsNull(Pedidos.PedidoExterior,'NO')='SI' and 
	DetCP.IdDetalleRecepcion is not null and DetCP.IdDetallePedido is null and 
	IsNull(DetPed.CostoAsignado,0)=0

 UNION ALL

 SELECT
  DetPed.IdDetallePedido,
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' '+
	'[ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' '+
	'item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  0,
  0,
  0,
  0,
  0,
  Case When IsNull(#Auxiliar8.ImporteRecepciones,0)<>0 Then (DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente) * (IsNull(#Auxiliar9.ImporteRecepcionesItem,0) / #Auxiliar8.ImporteRecepciones) Else 0 End,
  0,
  0,
  0,
  0,
  Case When IsNull(#Auxiliar8.ImporteRecepciones,0)<>0 
	Then 	Case When cp.IdMoneda=@IdMonedaDolar 
			Then DetCP.Importe * (IsNull(#Auxiliar9.ImporteRecepcionesItem,0) / #Auxiliar8.ImporteRecepciones)
			Else 	Case When IsNull(cp.CotizacionDolar,0)<>0 
					Then Round(DetCP.Importe * IsNull(cp.CotizacionMoneda,1)  / cp.CotizacionDolar * 	(IsNull(#Auxiliar9.ImporteRecepcionesItem,0) / #Auxiliar8.ImporteRecepciones),2)
					Else 0
				End		End * TiposComprobante.Coeficiente
	Else 0
  End,
  0,
  DetPed.IdArticulo
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN Pedidos ON DetCP.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN #Auxiliar8 ON DetCP.IdPedido = #Auxiliar8.IdPedido
 LEFT OUTER JOIN DetallePedidos DetPed ON Pedidos.IdPedido = DetPed.IdPedido
 LEFT OUTER JOIN #Auxiliar9 ON DetPed.IdDetallePedido = #Auxiliar9.IdDetallePedido
 LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE DetCP.IdPedido is not null and IsNull(Pedidos.PedidoExterior,'NO')='SI' and 
	DetCP.IdDetalleRecepcion is null and DetCP.IdDetallePedido is null and 
	IsNull(DetPed.CostoAsignado,0)=0

 UNION ALL

 SELECT
  DetPed.IdDetallePedido,
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' '+
	'[ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' '+
	'item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  0,
  0,
  0,
  0,
  0,
  DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente,
  0,
  0,
  0,
  0,
  Case When cp.IdMoneda=@IdMonedaDolar 
	Then DetCP.Importe
	Else 	Case When IsNull(cp.CotizacionDolar,0)<>0 
			Then Round(DetCP.Importe * IsNull(cp.CotizacionMoneda,1)  / cp.CotizacionDolar,2)
			Else 0
		End
  End * TiposComprobante.Coeficiente,
  0,
  DetPed.IdArticulo
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN DetallePedidos DetPed ON DetCP.IdDetallePedido = DetPed.IdDetallePedido
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.PedidoExterior,'NO')='SI' and DetCP.IdDetallePedido is not null and 
	IsNull(DetPed.CostoAsignado,0)=0

 UNION ALL

 SELECT
  DetPed.IdDetallePedido,
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' '+
	'[ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' '+
	'item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null 
			 Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  0,
  DetRec.Cantidad,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  DetRec.IdArticulo
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE DetRec.IdDetallePedido is not null and IsNull(Pedidos.PedidoExterior,'NO')='SI' and 
	IsNull(DetPed.CostoAsignado,0)=0 and IsNull(Recepciones.Anulada,'NO')<>'SI'

CREATE TABLE #Auxiliar2 
			(
			 IdDetallePedido INT,
			 Articulo VARCHAR(300),
			 Pedido VARCHAR(12),
			 DatosPedido VARCHAR(110),
			 Cantidad NUMERIC(18,2),
			 Entregado NUMERIC(18, 2),
			 CostoPedido NUMERIC(18, 4),
			 CostoItemPedido NUMERIC(18, 4),
			 TotalPedido NUMERIC(18, 2),
			 TotalComprobantes NUMERIC(18, 2),
			 CostoAAsignar NUMERIC(18, 4),
			 CostoItemPedidoDolar NUMERIC(18, 2),
			 TotalPedidoDolar NUMERIC(18, 2),
			 TotalComprobantesDolar NUMERIC(18, 2),
			 CostoAAsignarDolar NUMERIC(18, 4),
			 IdArticulo INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT 
  IdDetallePedido,
  Articulo,
  Pedido,
  DatosPedido,
  SUM(Cantidad),
  SUM(Entregado),
  MAX(CostoPedido),
  SUM(CostoItemPedido),
  SUM(TotalPedido),
  SUM(TotalComprobantes),
  0,
  SUM(CostoItemPedidoDolar),
  SUM(TotalPedidoDolar),
  SUM(TotalComprobantesDolar),
  0,
  IdArticulo
 FROM #Auxiliar1
 GROUP BY IdDetallePedido,Articulo,Pedido,DatosPedido,IdArticulo

UPDATE #Auxiliar2
SET CostoAAsignar=ROUND(TotalComprobantes / Case When Entregado<>0 Then Entregado Else Cantidad End,4)
/*ROUND(TotalComprobantes * CostoItemPedido / TotalPedido / 
			Case When Entregado<>0 Then Entregado Else Cantidad End,4) */
WHERE Entregado<>0 or Cantidad<>0

UPDATE #Auxiliar2
SET CostoAAsignarDolar=ROUND(TotalComprobantesDolar / Case When Entregado<>0 Then Entregado Else Cantidad End,4)
WHERE (Entregado<>0 or Cantidad<>0) 
/*
SET CostoAAsignarDolar=ROUND(TotalComprobantesDolar * CostoItemPedidoDolar / TotalPedidoDolar / 
				Case When Entregado<>0 Then Entregado Else Cantidad End,4)
WHERE (Entregado<>0 or Cantidad<>0) and TotalPedidoDolar<>0
*/

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111116666616661133'
SET @vector_T='00951334444495769900'

SELECT 
 IdDetallePedido as [IdDetallePedido],
 Substring(Articulo,1,150) as [Articulo],
 IdDetallePedido as [IdAux],
 Pedido as [Pedido],
 DatosPedido as [Datos del item de pedido],
 Cantidad,
 Entregado,
 Convert(Numeric(18,2),CostoPedido) as [Costo pedido],
 Convert(Numeric(18,2),CostoItemPedido) as [Costo Tot. Item],
 TotalPedido as [Total pedido],
 TotalComprobantes as [Total comprobante],
 Convert(Numeric(18,2),CostoAAsignar) as [Costo a asignar],
 CostoAAsignar,
 TotalPedidoDolar as [Total pedido u$s],
 TotalComprobantesDolar as [Total comprobante u$s],
 Convert(Numeric(18,2),CostoAAsignarDolar) as [Costo a asignar u$s],
 CostoAAsignarDolar,
 IdArticulo,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9