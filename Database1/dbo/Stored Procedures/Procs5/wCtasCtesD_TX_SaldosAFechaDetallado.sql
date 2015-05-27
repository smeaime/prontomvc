CREATE Procedure [dbo].[wCtasCtesD_TX_SaldosAFechaDetallado]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar0 (IdCliente INTEGER, SaldoPesos NUMERIC(18, 2))
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdCliente) ON [PRIMARY]
INSERT INTO #Auxiliar0 
 SELECT CtaCte.IdCliente, Sum(IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente)
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos Rec ON Rec.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE CtaCte.Fecha<=@FechaHasta 
 GROUP BY CtaCte.IdCliente

CREATE TABLE #Auxiliar1 (IdCliente INTEGER, SaldoPesos NUMERIC(18, 2))
INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdCliente, Sum(IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente)
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos Rec ON Rec.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE CtaCte.Fecha<@FechaDesde 
 GROUP BY CtaCte.IdCliente

SET NOCOUNT OFF

SELECT  
 0 as [K_Orden],
 Clientes.RazonSocial+' ['+Clientes.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+']' as [Cliente],
 @FechaDesde as [Fecha],
 Null as [IdTipoComprobante],
 Null as [IdComprobante],
 'SALDO INICIAL AL '+Convert(varchar,@FechaDesde,103) as [Comprobante],
 Null as [Detalle],
 #Auxiliar1.SaldoPesos as [Importe]
FROM #Auxiliar1
LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdCliente=#Auxiliar1.IdCliente
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar1.IdCliente
LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad=Localidades.IdLocalidad
LEFT OUTER JOIN Provincias ON Clientes.IdProvincia=Provincias.IdProvincia
WHERE IsNull(#Auxiliar0.SaldoPesos,0)<>0

UNION ALL

SELECT  
 1 as [K_Orden],
 Clientes.RazonSocial+' ['+Clientes.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS+']' as [Cliente],
 CtaCte.Fecha as [Fecha],
 CtaCte.IdTipoComp as [IdTipoComprobante],
 CtaCte.IdComprobante as [IdComprobante],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and IsNull(CtaCte.IdComprobante,0)>0
	 Then TiposComprobante.DescripcionAb+' '+Fac.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura)+' '+
		' del '+Convert(varchar,CtaCte.Fecha,103)
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones and IsNull(CtaCte.IdComprobante,0)>0
	 Then TiposComprobante.DescripcionAb+' '+Dev.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion)+' '+
		' del '+Convert(varchar,CtaCte.Fecha,103)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito and IsNull(CtaCte.IdComprobante,0)>0
	 Then TiposComprobante.DescripcionAb+' '+Deb.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito)+' '+
		' del '+Convert(varchar,CtaCte.Fecha,103)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito and IsNull(CtaCte.IdComprobante,0)>0
	 Then TiposComprobante.DescripcionAb+' '+Cre.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito)+' '+
		' del '+Convert(varchar,CtaCte.Fecha,103)
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo and IsNull(CtaCte.IdComprobante,0)>0
	 Then TiposComprobante.DescripcionAb+' '+
		Substring('0000',1,4-Len(Convert(varchar,Rec.PuntoVenta)))+Convert(varchar,Rec.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Rec.NumeroRecibo)))+Convert(varchar,Rec.NumeroRecibo)+' '+
		' del '+Convert(varchar,CtaCte.Fecha,103)
	 Else IsNull(TiposComprobante.DescripcionAb,'')+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)+' '+
		' del '+Convert(varchar,CtaCte.Fecha,103)
 End as [Comprobante],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta and IsNull(CtaCte.IdComprobante,0)>0
	 Then Fac.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones and IsNull(CtaCte.IdComprobante,0)>0
	 Then Dev.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito and IsNull(CtaCte.IdComprobante,0)>0
	 Then Deb.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito and IsNull(CtaCte.IdComprobante,0)>0
	 Then Cre.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo and IsNull(CtaCte.IdComprobante,0)>0
	 Then Rec.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS
	 Else Null
 End as [Detalle],
 CtaCte.ImporteTotal * TiposComprobante.Coeficiente as [Importe]
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos Rec ON Rec.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
WHERE IsNull(#Auxiliar0.SaldoPesos,0)<>0 and CtaCte.Fecha>=@FechaDesde and CtaCte.Fecha<=@FechaHasta 

ORDER BY [Cliente], [K_Orden], [Fecha]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1