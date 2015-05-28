CREATE Procedure [dbo].[CtasCtesD_TXPorTrs_Dolares]

@IdCliente int,
@Todo int,
@FechaLimite datetime,
@FechaDesde datetime = Null

AS 

SET NOCOUNT ON

SET @FechaDesde=IsNull(@FechaDesde,Convert(datetime,'1/1/2000'))

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1
			(
			 A_IdComprobante INTEGER,
			 A_IdTipoComprobante INTEGER,
			 A_Observaciones NTEXT,
			 A_Comprobante VARCHAR(16),
			 A_Obra VARCHAR(13),
			 A_OrdenCompra VARCHAR(20),
			 A_IdMoneda INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdComprobante,
  CtaCte.IdTipoComp,
  Substring(Convert(varchar(2000),Facturas.Observaciones),1,2000),
  Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+
	Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+
	Convert(varchar,Facturas.NumeroFactura),
  Obras.NumeroObra, 
  Null, 
  Facturas.IdMoneda
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante
 LEFT OUTER JOIN Obras ON Obras.IdObra=Facturas.IdObra
 WHERE CtaCte.IdCliente=@IdCliente and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 
 GROUP BY CtaCte.IdComprobante, CtaCte.IdTipoComp, Facturas.TipoABC, Facturas.PuntoVenta, Facturas.NumeroFactura, 
	Obras.NumeroObra, Substring(Convert(varchar(2000),Facturas.Observaciones),1,2000), Facturas.IdMoneda

 UNION ALL

 SELECT 
  CtaCte.IdComprobante,
  CtaCte.IdTipoComp,
  Substring(Convert(varchar(2000),Devoluciones.Observaciones),1,2000),
  Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion),
  Obras.NumeroObra, 
  Null, 
  Devoluciones.IdMoneda
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante
 LEFT OUTER JOIN Obras ON Obras.IdObra=Devoluciones.IdObra
 WHERE CtaCte.IdCliente=@IdCliente and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 
 GROUP BY CtaCte.IdComprobante, CtaCte.IdTipoComp, Devoluciones.TipoABC, Devoluciones.PuntoVenta, Devoluciones.NumeroDevolucion, 
	Obras.NumeroObra, Substring(Convert(varchar(2000),Devoluciones.Observaciones),1,2000), Devoluciones.IdMoneda

 UNION ALL

 SELECT 
  CtaCte.IdComprobante,
  CtaCte.IdTipoComp,
  Substring(Convert(varchar(2000),NotasDebito.Observaciones),1,2000),
  NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
  Obras.NumeroObra, 
  Null, 
  NotasDebito.IdMoneda
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante
 LEFT OUTER JOIN Obras ON Obras.IdObra=NotasDebito.IdObra
 WHERE CtaCte.IdCliente=@IdCliente and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 
 GROUP BY CtaCte.IdComprobante, CtaCte.IdTipoComp, NotasDebito.TipoABC, NotasDebito.PuntoVenta, NotasDebito.NumeroNotaDebito, 
	Obras.NumeroObra, Substring(Convert(varchar(2000),NotasDebito.Observaciones),1,2000), NotasDebito.IdMoneda

 UNION ALL

 SELECT 
  CtaCte.IdComprobante,
  CtaCte.IdTipoComp,
  Substring(Convert(varchar(2000),NotasCredito.Observaciones),1,2000),
  NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
  Obras.NumeroObra, 
  Null, 
  NotasCredito.IdMoneda
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante
 LEFT OUTER JOIN Obras ON Obras.IdObra=NotasCredito.IdObra
 WHERE CtaCte.IdCliente=@IdCliente and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 
 GROUP BY CtaCte.IdComprobante, CtaCte.IdTipoComp, NotasCredito.TipoABC, NotasCredito.PuntoVenta, NotasCredito.NumeroNotaCredito, 
	Obras.NumeroObra, Substring(Convert(varchar(2000),NotasCredito.Observaciones),1,2000), NotasCredito.IdMoneda

 UNION ALL

 SELECT 
  CtaCte.IdComprobante,
  CtaCte.IdTipoComp,
  Substring(Convert(varchar(2000),Recibos.Observaciones),1,2000),
  Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo), 
  Null, 
  Null, 
  Recibos.IdMoneda
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante
 WHERE CtaCte.IdCliente=@IdCliente and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 
 GROUP BY CtaCte.IdComprobante, CtaCte.IdTipoComp, Recibos.PuntoVenta, Recibos.NumeroRecibo, 
	Substring(Convert(varchar(2000),Recibos.Observaciones),1,2000), Recibos.IdMoneda

UPDATE #Auxiliar1
SET A_OrdenCompra=(Select Top 1 oc.NumeroOrdenCompraCliente
			From DetalleFacturasOrdenesCompra dfoc 
			Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra
			Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra
			Where dfoc.IdFactura=#Auxiliar1.A_IdComprobante)
WHERE A_IdTipoComprobante=@IdTipoComprobanteFacturaVenta

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)
SET @vector_X='0011111188151111111133'
SET @vector_T='0019904455559992333900'
SET @vector_E='  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  |  |  '

SELECT 
 CtaCte.IdCtaCte,
 CtaCte.IdImputacion,
 TiposComprobante.DescripcionAB as [Comp.],
 CtaCte.IdTipoComp,
 CtaCte.IdComprobante,
 Case When A_Comprobante is not null 
	Then #Auxiliar1.A_Comprobante 
	Else Substring('000000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
 End as [Numero],
 CtaCte.Fecha,
 CtaCte.FechaVencimiento as [Fecha vto.],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotalDolar Else CtaCte.ImporteTotalDolar*-1 End as [Imp.orig.],
 Case When @Todo=-1 Then Case When TiposComprobante.Coeficiente=1 Then CtaCte.SaldoDolar Else CtaCte.SaldoDolar*-1 End 
	Else Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotalDolar Else CtaCte.ImporteTotalDolar*-1 End 
 End as [Saldo Comp.],
 CtaCte.SaldoTrs,
 #Auxiliar1.A_Observaciones as [Observaciones],
 Case When CtaCte.IdCtaCte=IsNull(CtaCte.IdImputacion,0) Then '0' Else '1' End as [Cabeza],
 CtaCte.IdImputacion as [IdImpu],
 CtaCte.IdCtaCte as [IdAux1],
 cc.Descripcion as [Cond. venta],
 #Auxiliar1.A_Obra as [Obra],
 #Auxiliar1.A_OrdenCompra as [Orden de compra],
 Monedas.Abreviatura as [Mon.origen],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.A_IdComprobante=CtaCte.IdComprobante and #Auxiliar1.A_IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN Monedas ON CtaCte.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(Facturas.IdObra,IsNull(Devoluciones.IdObra,IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,0))))
LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=IsNull(Facturas.IdVendedor,IsNull(Devoluciones.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,IsNull(Recibos.IdVendedor,0)))))
LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra=Facturas.IdCondicionVenta
WHERE CtaCte.IdCliente=@IdCliente and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite) 
ORDER by CtaCte.IdImputacion, [Cabeza], CtaCte.Fecha

DROP TABLE #Auxiliar1