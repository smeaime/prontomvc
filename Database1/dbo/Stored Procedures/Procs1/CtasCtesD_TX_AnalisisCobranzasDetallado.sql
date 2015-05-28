CREATE Procedure [dbo].[CtasCtesD_TX_AnalisisCobranzasDetallado]

@Fecha datetime

AS 

SET NOCOUNT ON

DECLARE @Desde datetime, @Hasta datetime, @Hasta2 datetime, @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, 
		@IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @PorcentajeIva numeric(18,2), 
		@FechaAux datetime, @Ventas numeric(18,2), @VentasAFecha numeric(18,2), @Saldo numeric(18,2)

SET @Desde=Convert(datetime,'01/'+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha)),103)
SET @Hasta=Dateadd(m,1,@Desde)
SET @Hasta=Dateadd(d,-1,@Hasta)
SET @Hasta2=Dateadd(m,1,@Fecha)

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @PorcentajeIva=(Select Top 1 Iva1 From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 Dia INTEGER,
			 Mes INTEGER,
			 Año INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Comprobante VARCHAR(20),
			 Ventas NUMERIC(18,2),
			 Facturacion NUMERIC(18,2),
			 NotasDebito NUMERIC(18,2),
			 NotasCredito NUMERIC(18,2),
			 Cobranzas NUMERIC(18,2)
			)

-- COMPROBANTES POR MES
INSERT INTO #Auxiliar1 
 SELECT 
	Day(Fac.FechaFactura),
	Month(Fac.FechaFactura),
	Year(Fac.FechaFactura),
	Fac.FechaFactura,
	@IdTipoComprobanteFacturaVenta,
	Fac.IdFactura,
	'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura),
	0,
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - 
			IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.AjusteIva,0) - IsNull(Fac.PercepcionIVA,0)) / 
			(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) -IsNull(Fac.AjusteIva,0) - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End, 
	0,
	0,
	0
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE IsNull(Fac.Anulada,'')<>'SI' and Fac.FechaFactura between @Desde and DATEADD(n,1439,@Hasta)

UNION ALL 

 SELECT 
	Day(Dev.FechaDevolucion),
	Month(Dev.FechaDevolucion),
	Year(Dev.FechaDevolucion),
	Dev.FechaDevolucion,
	@IdTipoComprobanteDevoluciones,
	Dev.IdDevolucion,
	'DEV '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	0,
	Case When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 and Dev.PorcentajeIva1<>0
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - IsNull(Dev.OtrasPercepciones1,0) - 
			IsNull(Dev.OtrasPercepciones2,0) - IsNull(Dev.PercepcionIVA,0)) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - 
			IsNull(Dev.OtrasPercepciones1,0) - IsNull(Dev.OtrasPercepciones2,0) - IsNull(Dev.PercepcionIVA,0)) * Dev.CotizacionMoneda
	End * -1, 
	0,
	0,
	0
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE IsNull(Dev.Anulada,'')<>'SI' and Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@Hasta2)

UNION ALL 

 SELECT 
	Day(Deb.FechaNotaDebito),
	Month(Deb.FechaNotaDebito),
	Year(Deb.FechaNotaDebito),
	Deb.FechaNotaDebito,
	@IdTipoComprobanteNotaDebito,
	Deb.IdNotaDebito,
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito),
	0,
	0,
	Case When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		Else (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * Deb.CotizacionMoneda
	End, 
	0,
	0
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE IsNull(Deb.Anulada,'')<>'SI' and Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@Hasta2)

UNION ALL 

 SELECT 
	Day(Cre.FechaNotaCredito),
	Month(Cre.FechaNotaCredito),
	Year(Cre.FechaNotaCredito),
	Cre.FechaNotaCredito,
	@IdTipoComprobanteNotaCredito,
	Cre.IdNotaCredito,
	'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito),
	0,
	0,
	0,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda
		Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * Cre.CotizacionMoneda
	End * -1, 
	0
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE IsNull(Cre.Anulada,'')<>'SI' and Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@Hasta2)
	
UNION ALL 

 SELECT 
	Day(Rec.FechaRecibo),
	Month(Rec.FechaRecibo),
	Year(Rec.FechaRecibo),
	Rec.FechaRecibo,
	@IdTipoComprobanteRecibo,
	Rec.IdRecibo,
	'REC '+Substring('0000',1,4-Len(Convert(varchar,Rec.PuntoVenta)))+Convert(varchar,Rec.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Rec.NumeroRecibo)))+Convert(varchar,Rec.NumeroRecibo),
	0,
	0,
	0,
	0,
	Case When IsNull(Cli.IdCodigoIva,1)<>8 
		Then Rec.Deudores / (1+(@PorcentajeIva/100)) * Rec.CotizacionMoneda
		Else Rec.Deudores * Rec.CotizacionMoneda
	End
 FROM Recibos Rec 
 LEFT OUTER JOIN Clientes Cli ON Rec.IdCliente = Cli.IdCliente 
 WHERE IsNull(Rec.Anulado,'')<>'SI' and Rec.FechaRecibo between @Desde and DATEADD(n,1439,@Hasta2) and IsNull(Rec.Tipo,'CC')='CC'

UPDATE #Auxiliar1 SET Ventas=IsNull(Facturacion,0)+IsNull(NotasDebito,0)+IsNull(NotasCredito,0)


CREATE TABLE #Auxiliar2 
			(
			 Dia INTEGER,
			 Mes INTEGER,
			 Año INTEGER,
			 Ventas NUMERIC(18,2),
			 Facturacion NUMERIC(18,2),
			 NotasDebito NUMERIC(18,2),
			 NotasCredito NUMERIC(18,2),
			 Cobranzas NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT Dia, Mes, Año, Sum(IsNull(Ventas,0)), Sum(IsNull(Facturacion,0)), Sum(IsNull(NotasDebito,0)), Sum(IsNull(NotasCredito,0)), Sum(IsNull(Cobranzas,0))
 FROM #Auxiliar1
 WHERE Fecha between @Fecha and DATEADD(n,1439,@Hasta2)
 GROUP BY Dia, Mes, Año

SET @Ventas=IsNull((Select Sum(IsNull(Ventas,0)) From #Auxiliar1 Where Fecha between @Desde and DATEADD(n,1439,@Hasta)),0)
SET @VentasAFecha=IsNull((Select Sum(IsNull(Ventas,0)) From #Auxiliar1 Where Fecha between @Desde and DATEADD(n,1439,@Fecha)),0)

SET @Saldo=IsNull((Select Sum(IsNull(CtaCte.ImporteTotal,0)*IsNull(TiposComprobante.Coeficiente,1))
					From CuentasCorrientesDeudores CtaCte
					Left Outer Join TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
					Where CtaCte.Fecha<=@Fecha),0)

SET NOCOUNT OFF

SELECT @Ventas as [VentasDelMes], @VentasAFecha as [VentasDelMesAFecha],@Saldo as [SaldoAnterior], Dia, Mes, Año, Ventas, Facturacion, NotasDebito, NotasCredito, Cobranzas
FROM #Auxiliar2 
ORDER BY Año, Mes, Dia

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2