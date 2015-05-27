CREATE Procedure [dbo].[CuboCostosImportacion]

@Dts varchar(200)

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
  Sum(IsNull(DetRec.Cantidad,0) * IsNull(DetPed.Precio,0))
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
  Sum(IsNull(DetRec.Cantidad,0) * IsNull(DetPed.Precio,0))
 FROM DetalleRecepciones DetRec
 LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion=Recepciones.IdRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 WHERE DetRec.IdDetallePedido is not null and IsNull(Recepciones.Anulada,'NO')<>'SI'
 GROUP BY DetRec.IdDetallePedido

CREATE TABLE #Auxiliar1 
			(
			 Articulo VARCHAR(280),
			 Pedido VARCHAR(12),
			 DatosPedido VARCHAR(200),
			 Origen VARCHAR(40),
			 Movimientos VARCHAR(200),
			 Cantidad NUMERIC(18,2),
			 Entregado NUMERIC(18, 2),
			 CostoPedido NUMERIC(18, 4),
			 CostoItemPedido NUMERIC(18, 2),
			 TotalPedido NUMERIC(18, 2),
			 TotalComprobantes NUMERIC(18, 2),
			 CostoAAsignar NUMERIC(18, 4),
			 CostoPedidoDolar NUMERIC(18, 4),
			 CostoItemPedidoDolar NUMERIC(18, 2),
			 TotalPedidoDolar NUMERIC(18, 2),
			 TotalComprobantesDolar NUMERIC(18, 2),
			 CostoAAsignarDolar NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar1 
 SELECT
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' [ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  Case 	When Acopios.NumeroAcopio is not null 
	 Then 'Acopio :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Acopios.NumeroAcopio,0))))+Convert(varchar,IsNull(Acopios.NumeroAcopio,0))+' '+
		'del '+Convert(varchar,Acopios.Fecha,103)+'  item '+Convert(varchar,IsNull(DetalleAcopios.NumeroItem,0))
	When Requerimientos.NumeroRequerimiento is not null 
	 Then 'RM :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))))+Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))+' '+
		'del '+Convert(varchar,Requerimientos.FechaRequerimiento,103)+' item '+Convert(varchar,IsNull(DetalleRequerimientos.NumeroItem,0))
	 Else Null
  End,
  ' ',
  DetPed.Cantidad,
  0,
  DetPed.Precio * IsNull(Pedidos.CotizacionMoneda,1),
  DetPed.Precio * IsNull(Pedidos.CotizacionMoneda,1) * DetPed.Cantidad,
  (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)-IsNull(Pedidos.TotalIva2,0)+IsNull(Pedidos.Bonificacion,0)) * IsNull(Pedidos.CotizacionMoneda,1),
  0,
  0,
  Case When Pedidos.IdMoneda=@IdMonedaDolar Then DetPed.Precio
	Else 	Case When IsNull(Pedidos.CotizacionDolar,0)<>0 
			Then Round(DetPed.Precio * IsNull(Pedidos.CotizacionMoneda,1) / Pedidos.CotizacionDolar,2)
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
	Then IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)-IsNull(Pedidos.TotalIva2,0)+IsNull(Pedidos.Bonificacion,0)
	Else 	Case When IsNull(Pedidos.CotizacionDolar,0)<>0 
			Then Round((IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)-
					IsNull(Pedidos.TotalIva2,0)+IsNull(Pedidos.Bonificacion,0)) * 
					IsNull(Pedidos.CotizacionMoneda,1) / Pedidos.CotizacionDolar,2)
			Else 0
		End
  End,
  0,
  0
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
 WHERE IsNull(Pedidos.PedidoExterior,'NO')='SI' and IsNull(DetPed.Cumplido,'NO')<>'AN' and IsNull(Pedidos.Cumplido,'NO')<>'AN'

 UNION ALL

 SELECT
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' [ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  Case 	When Acopios.NumeroAcopio is not null 
	 Then 'Acopio :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Acopios.NumeroAcopio,0))))+Convert(varchar,IsNull(Acopios.NumeroAcopio,0))+' '+
		'del '+Convert(varchar,Acopios.Fecha,103)+'  item '+Convert(varchar,IsNull(DetalleAcopios.NumeroItem,0))	When Requerimientos.NumeroRequerimiento is not null 
	 Then 'RM :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))))+Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))+' '+		'del '+Convert(varchar,Requerimientos.FechaRequerimiento,103)+' item '+Convert(varchar,IsNull(DetalleRequerimientos.NumeroItem,0))
	 Else Null
  End,
  'CP : Ref. '+Convert(varchar,cp.NumeroReferencia)+' '+
  	cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' '+
	'del '+Convert(varchar,cp.FechaRecepcion,103)+' Prov. '+Proveedores.RazonSocial,
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
			Then Round(DetCP.Importe * IsNull(cp.CotizacionMoneda,1) / cp.CotizacionDolar,2)
			Else 0
		End
  End * TiposComprobante.Coeficiente,
  0
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN Pedidos ON DetCP.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN DetalleRecepciones DetRec ON DetCP.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
 LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
 LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,cp.IdProveedorEventual) = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE DetCP.IdPedido is not null and IsNull(Pedidos.PedidoExterior,'NO')='SI' and 
	DetCP.IdDetalleRecepcion is not null and DetCP.IdDetallePedido is null

 UNION ALL

 SELECT
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' [ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  Case 	When Acopios.NumeroAcopio is not null 
	 Then 'Acopio :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Acopios.NumeroAcopio,0))))+Convert(varchar,IsNull(Acopios.NumeroAcopio,0))+' '+
		'del '+Convert(varchar,Acopios.Fecha,103)+'  item '+Convert(varchar,IsNull(DetalleAcopios.NumeroItem,0))
	When Requerimientos.NumeroRequerimiento is not null 
	 Then 'RM :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))))+Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))+' '+
		'del '+Convert(varchar,Requerimientos.FechaRequerimiento,103)+' item '+Convert(varchar,IsNull(DetalleRequerimientos.NumeroItem,0))
	 Else Null
  End,
  'CP : Ref. '+Convert(varchar,cp.NumeroReferencia)+' '+
  	cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' '+
	'del '+Convert(varchar,cp.FechaRecepcion,103)+' Prov. '+Proveedores.RazonSocial,
  0,
  0,
  0,
  0,
  0,
  Case When IsNull(#Auxiliar8.ImporteRecepciones,0)<>0 
	Then (DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente) * (IsNull(#Auxiliar9.ImporteRecepcionesItem,0) / #Auxiliar8.ImporteRecepciones)
	Else 0
  End,
  0,
  0,
  0,
  0,
  Case When IsNull(#Auxiliar8.ImporteRecepciones,0)<>0 
	Then 	Case When cp.IdMoneda=@IdMonedaDolar 
			Then DetCP.Importe * 
				(IsNull(#Auxiliar9.ImporteRecepcionesItem,0) / #Auxiliar8.ImporteRecepciones)
			Else 	Case When IsNull(cp.CotizacionDolar,0)<>0 
					Then Round(DetCP.Importe * IsNull(cp.CotizacionMoneda,1) / cp.CotizacionDolar * 
							(IsNull(#Auxiliar9.ImporteRecepcionesItem,0) / #Auxiliar8.ImporteRecepciones),2)
					Else 0
				End		End * TiposComprobante.Coeficiente
	Else 0
  End,
  0
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN Pedidos ON DetCP.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN #Auxiliar8 ON DetCP.IdPedido = #Auxiliar8.IdPedido
 LEFT OUTER JOIN DetallePedidos DetPed ON Pedidos.IdPedido = DetPed.IdPedido
 LEFT OUTER JOIN #Auxiliar9 ON DetPed.IdDetallePedido = #Auxiliar9.IdDetallePedido
 LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,cp.IdProveedorEventual) = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE DetCP.IdPedido is not null and IsNull(Pedidos.PedidoExterior,'NO')='SI' and 
	DetCP.IdDetalleRecepcion is null and IsNull(#Auxiliar9.ImporteRecepcionesItem,0)<>0 and DetCP.IdDetallePedido is null

 UNION ALL

 SELECT
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' [ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  Case 	When Acopios.NumeroAcopio is not null 
	 Then 'Acopio :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Acopios.NumeroAcopio,0))))+Convert(varchar,IsNull(Acopios.NumeroAcopio,0))+' '+
		'del '+Convert(varchar,Acopios.Fecha,103)+'  item '+Convert(varchar,IsNull(DetalleAcopios.NumeroItem,0))	When Requerimientos.NumeroRequerimiento is not null 
	 Then 'RM :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))))+Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))+' '+		'del '+Convert(varchar,Requerimientos.FechaRequerimiento,103)+' item '+Convert(varchar,IsNull(DetalleRequerimientos.NumeroItem,0))
	 Else Null
  End,
  'CP : Ref. '+Convert(varchar,cp.NumeroReferencia)+' '+
  	cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' '+
	'del '+Convert(varchar,cp.FechaRecepcion,103)+' Prov. '+Proveedores.RazonSocial,
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
			Then Round(DetCP.Importe * IsNull(cp.CotizacionMoneda,1) / cp.CotizacionDolar,2)
			Else 0
		End
  End * TiposComprobante.Coeficiente,
  0
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN DetallePedidos DetPed ON DetCP.IdDetallePedido = DetPed.IdDetallePedido
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,cp.IdProveedorEventual) = Proveedores.IdProveedor
 LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuentaCompras = Cuentas.IdCuenta
 LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
 LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.PedidoExterior,'NO')='SI' and DetCP.IdDetallePedido is not null

 UNION ALL

 SELECT
  Case When Articulos.Codigo is not null 
	Then '['+Convert(varchar,Articulos.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS)+'] ' 
	Else '' 
  End+Articulos.Descripcion+' [ Cta.'+Convert(varchar,IsNull(Cuentas.Codigo,0))+' ]',
  Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0)),
  'Pedido :'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Pedidos.NumeroPedido,0))))+Convert(varchar,IsNull(Pedidos.NumeroPedido,0))+'/'+
	Substring('000',1,3-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+Convert(varchar,IsNull(Pedidos.SubNumero,0))+' '+
	'del '+Convert(varchar,Pedidos.FechaPedido,103)+' item '+Convert(varchar,IsNull(DetPed.NumeroItem,0))+' '+
	Case When Unidades.Abreviatura is not null Then 'en '+Unidades.Abreviatura Else '' End+' '+
	'Obra '+Case When Acopios.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			When Requerimientos.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			 Else ''
		End,
  Case 	When Acopios.NumeroAcopio is not null 
	 Then 'Acopio :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Acopios.NumeroAcopio,0))))+Convert(varchar,IsNull(Acopios.NumeroAcopio,0))+' '+
		'del '+Convert(varchar,Acopios.Fecha,103)+'  item '+Convert(varchar,IsNull(DetalleAcopios.NumeroItem,0))
	When Requerimientos.NumeroRequerimiento is not null 
	 Then 'RM :'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))))+Convert(varchar,IsNull(Requerimientos.NumeroRequerimiento,0))+' '+
		'del '+Convert(varchar,Requerimientos.FechaRequerimiento,103)+' item '+Convert(varchar,IsNull(DetalleRequerimientos.NumeroItem,0))
	 Else Null
  End,
  'REC : '+Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
	Convert(varchar,IsNull(Recepciones.SubNumero,0))+' del '+Convert(varchar,Recepciones.FechaRecepcion,103)+' Prov. '+Proveedores.RazonSocial,
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
  0
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
 WHERE DetRec.IdDetallePedido is not null and IsNull(Pedidos.PedidoExterior,'NO')='SI' and IsNull(Recepciones.Anulada,'NO')<>'SI'

CREATE TABLE #Auxiliar2 
			(
			 Articulo VARCHAR(280),
			 Pedido VARCHAR(12),
			 DatosPedido VARCHAR(200),
			 Origen VARCHAR(40),
			 Movimientos VARCHAR(200),
			 Cantidad NUMERIC(18,2),
			 Entregado NUMERIC(18, 2),
			 CostoPedido NUMERIC(18, 4),
			 CostoItemPedido NUMERIC(18, 2),
			 TotalPedido NUMERIC(18, 2),
			 TotalComprobantes NUMERIC(18, 2),
			 CostoAAsignar NUMERIC(18, 4),
			 CostoPedidoDolar NUMERIC(18, 4),
			 CostoItemPedidoDolar NUMERIC(18, 2),
			 TotalPedidoDolar NUMERIC(18, 2),
			 TotalComprobantesDolar NUMERIC(18, 2),
			 CostoAAsignarDolar NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar2 
 SELECT
  #Auxiliar1.Articulo,
  #Auxiliar1.Pedido,
  #Auxiliar1.DatosPedido,
  #Auxiliar1.Origen,
  #Auxiliar1.Movimientos,
  SUM(#Auxiliar1.Cantidad),
  SUM(#Auxiliar1.Entregado),
  SUM(#Auxiliar1.CostoPedido),
  SUM(#Auxiliar1.CostoItemPedido),
  SUM(#Auxiliar1.TotalPedido),
  SUM(#Auxiliar1.TotalComprobantes),
  0,
  SUM(#Auxiliar1.CostoPedidoDolar),
  SUM(#Auxiliar1.CostoItemPedidoDolar),
  SUM(#Auxiliar1.TotalPedidoDolar),
  SUM(#Auxiliar1.TotalComprobantesDolar),
  0
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.Articulo, #Auxiliar1.Pedido, #Auxiliar1.DatosPedido, #Auxiliar1.Origen, #Auxiliar1.Movimientos

CREATE TABLE #Auxiliar3 
			(
			 Articulo VARCHAR(280),
			 DatosPedido VARCHAR(200),
			 Cantidad NUMERIC(18,2),
			 Entregado NUMERIC(18, 2),
			 CostoItemPedido NUMERIC(18, 2),
			 TotalPedido NUMERIC(18, 2),
			 TotalComprobantes NUMERIC(18, 2),
			 CostoAAsignar NUMERIC(18, 4),
			 CostoItemPedidoDolar NUMERIC(18, 2),
			 TotalPedidoDolar NUMERIC(18, 2),
			 TotalComprobantesDolar NUMERIC(18, 2),
			 CostoAAsignarDolar NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.Articulo,
  #Auxiliar2.DatosPedido,
  SUM(#Auxiliar2.Cantidad),
  SUM(#Auxiliar2.Entregado),
  SUM(#Auxiliar2.CostoItemPedido),
  SUM(#Auxiliar2.TotalPedido),
  SUM(#Auxiliar2.TotalComprobantes),
  0,
  SUM(#Auxiliar2.CostoItemPedidoDolar),
  SUM(#Auxiliar2.TotalPedidoDolar),
  SUM(#Auxiliar2.TotalComprobantesDolar),
  0
FROM #Auxiliar2
GROUP BY #Auxiliar2.Articulo,#Auxiliar2.DatosPedido

UPDATE #Auxiliar3
SET CostoAAsignar=ROUND(TotalComprobantes / 
			Case When Entregado<>0 Then Entregado Else Cantidad End,4)
/*ROUND(TotalComprobantes * CostoItemPedido / TotalPedido / 
			Case When Entregado<>0 Then Entregado Else Cantidad End,4) */
WHERE Entregado<>0 or Cantidad<>0

UPDATE #Auxiliar3
SET CostoAAsignarDolar=ROUND(TotalComprobantesDolar / 
				Case When Entregado<>0 Then Entregado Else Cantidad End,4)
WHERE (Entregado<>0 or Cantidad<>0) 
/*SET CostoAAsignarDolar=ROUND(TotalComprobantesDolar * CostoItemPedidoDolar / TotalPedidoDolar / 
				Case When Entregado<>0 Then Entregado Else Cantidad End,4)
WHERE (Entregado<>0 or Cantidad<>0) and TotalPedidoDolar<>0*/

TRUNCATE TABLE _TempCuboCostosImportacion
INSERT INTO _TempCuboCostosImportacion 
 SELECT 
  #Auxiliar2.Articulo,
  #Auxiliar2.Pedido,
  #Auxiliar2.DatosPedido,
  #Auxiliar2.Origen,
  #Auxiliar2.Movimientos,
  #Auxiliar2.Cantidad,
  #Auxiliar2.Entregado,
  #Auxiliar2.CostoPedido,
  #Auxiliar2.CostoItemPedido,
  #Auxiliar2.TotalPedido,
  #Auxiliar2.TotalComprobantes,
  Case 	When #Auxiliar2.CostoPedido<>0 
	 Then #Auxiliar3.CostoAAsignar 
	When #Auxiliar2.TotalComprobantes<>0  and #Auxiliar3.Entregado<>0 and #Auxiliar3.Cantidad<>0
	 Then Round(#Auxiliar2.TotalComprobantes / Case When #Auxiliar3.Entregado<>0 Then #Auxiliar3.Entregado Else #Auxiliar3.Cantidad End,4)
	 Else 0 
  End,
  #Auxiliar2.CostoPedidoDolar,
  #Auxiliar2.CostoItemPedidoDolar,
  #Auxiliar2.TotalPedidoDolar,
  #Auxiliar2.TotalComprobantesDolar,
  Case When #Auxiliar2.CostoPedido<>0 Then #Auxiliar3.CostoAAsignarDolar Else 0 End
FROM #Auxiliar2
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar2.Articulo=#Auxiliar3.Articulo and #Auxiliar2.DatosPedido=#Auxiliar3.DatosPedido

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF