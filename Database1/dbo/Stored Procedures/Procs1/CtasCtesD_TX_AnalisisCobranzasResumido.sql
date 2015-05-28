CREATE Procedure [dbo].[CtasCtesD_TX_AnalisisCobranzasResumido]

@Fecha datetime

AS 

SET NOCOUNT ON

DECLARE @Desde datetime, @Hasta datetime, @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, 
		@IdTipoComprobanteRecibo int, @PorcentajeIva numeric(18,2), @FechaAux datetime, @Saldo numeric(18,2)

SET @Fecha=Convert(datetime,'01/'+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha)),103)
SET @Desde=Dateadd(m,-13,@Fecha)
SET @Hasta=Dateadd(d,-1,@Fecha)

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @PorcentajeIva=(Select Top 1 Iva1 From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 Mes INTEGER,
			 Año INTEGER,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Comprobante VARCHAR(20),
			 Ventas NUMERIC(18,2),
			 Cobranzas NUMERIC(18,2)
			)

-- COMPROBANTES POR MES
INSERT INTO #Auxiliar1 
 SELECT 
	Month(Fac.FechaFactura),
	Year(Fac.FechaFactura),
	@IdTipoComprobanteFacturaVenta,
	Fac.IdFactura,
	'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura),
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - 
			IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.AjusteIva,0) - IsNull(Fac.PercepcionIVA,0)) / 
			(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) -IsNull(Fac.AjusteIva,0) - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End, 
	0
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE IsNull(Fac.Anulada,'')<>'SI' and Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta)

UNION ALL 

 SELECT 
	Month(Dev.FechaDevolucion),
	Year(Dev.FechaDevolucion),
	@IdTipoComprobanteDevoluciones,
	Dev.IdDevolucion,
	'DEV '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	Case When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 and Dev.PorcentajeIva1<>0
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - IsNull(Dev.OtrasPercepciones1,0) - 
			IsNull(Dev.OtrasPercepciones2,0) - IsNull(Dev.PercepcionIVA,0)) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - 
			IsNull(Dev.OtrasPercepciones1,0) - IsNull(Dev.OtrasPercepciones2,0) - IsNull(Dev.PercepcionIVA,0)) * Dev.CotizacionMoneda
	End * -1, 
	0
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE IsNull(Dev.Anulada,'')<>'SI' and Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)

UNION ALL 

 SELECT 
	Month(Deb.FechaNotaDebito),
	Year(Deb.FechaNotaDebito),
	@IdTipoComprobanteNotaDebito,
	Deb.IdNotaDebito,
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito),
	Case When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		Else (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * Deb.CotizacionMoneda
	End, 
	0
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE IsNull(Deb.Anulada,'')<>'SI' and Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)

UNION ALL 

 SELECT 
	Month(Cre.FechaNotaCredito),
	Year(Cre.FechaNotaCredito),
	@IdTipoComprobanteNotaCredito,
	Cre.IdNotaCredito,
	'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito),
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda
		Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * Cre.CotizacionMoneda
	End * -1, 
	0
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE IsNull(Cre.Anulada,'')<>'SI' and Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)
	
UNION ALL 

 SELECT 
	Month(Rec.FechaRecibo),
	Year(Rec.FechaRecibo),
	@IdTipoComprobanteRecibo,
	Rec.IdRecibo,
	'REC '+Substring('0000',1,4-Len(Convert(varchar,Rec.PuntoVenta)))+Convert(varchar,Rec.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Rec.NumeroRecibo)))+Convert(varchar,Rec.NumeroRecibo),
	0,

	Case When IsNull(Cli.IdCodigoIva,1)<>8 
		Then Rec.Deudores / (1+(@PorcentajeIva/100)) * Rec.CotizacionMoneda
		Else Rec.Deudores * Rec.CotizacionMoneda
	End
 FROM Recibos Rec 
 LEFT OUTER JOIN Clientes Cli ON Rec.IdCliente = Cli.IdCliente 
 WHERE IsNull(Rec.Anulado,'')<>'SI' and Rec.FechaRecibo between @Desde and DATEADD(n,1439,@hasta) and IsNull(Rec.Tipo,'CC')='CC'

CREATE TABLE #Auxiliar9 
			(
			 Mes INTEGER,
			 Año INTEGER,
			 Ventas NUMERIC(18,2),
			 Cobranzas NUMERIC(18,2)
			)
INSERT INTO #Auxiliar9 
 SELECT Mes, Año, Sum(IsNull(Ventas,0)), Sum(IsNull(Cobranzas,0))
 FROM #Auxiliar1
 GROUP BY Mes, Año
 

-- SALDO DE CUENTAS CORRIENTES A FIN DE CADA MES
CREATE TABLE #Auxiliar2 
			(
			 Mes INTEGER,
			 Año INTEGER,
			 Saldo NUMERIC(18, 2)
			)

SET @FechaAux=@Desde
WHILE @FechaAux<=@Hasta
  BEGIN
	SET @Saldo=IsNull((Select Sum(IsNull(CtaCte.ImporteTotal,0)*IsNull(TiposComprobante.Coeficiente,1))
						From CuentasCorrientesDeudores CtaCte
						Left Outer Join TiposComprobante On TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
						Where CtaCte.Fecha<=@FechaAux),0)

	INSERT INTO #Auxiliar2 (Mes, Año, Saldo) VALUES (Month(@FechaAux), Year(@FechaAux), @Saldo)
	IF Not Exists(Select Top 1 Mes From #Auxiliar9 Where Mes=Month(@FechaAux) and Año=Year(@FechaAux))
		INSERT INTO #Auxiliar9 (Mes, Año, Ventas, Cobranzas) VALUES (Month(@FechaAux), Year(@FechaAux), 0, 0)

	SET @FechaAux=Dateadd(m,1,@FechaAux)
  END

SET NOCOUNT OFF

SELECT #Auxiliar9.año, #Auxiliar9.mes, #Auxiliar9.Ventas, #Auxiliar9.Cobranzas, #Auxiliar2.Saldo
FROM #Auxiliar9 
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.Mes=#Auxiliar9.Mes and #Auxiliar2.Año=#Auxiliar9.Año
ORDER BY #Auxiliar9.año, #Auxiliar9.mes

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar9