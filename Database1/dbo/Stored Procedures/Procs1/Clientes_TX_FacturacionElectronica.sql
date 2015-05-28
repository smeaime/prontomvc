CREATE Procedure [dbo].[Clientes_TX_FacturacionElectronica]

@Desde datetime,
@Hasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int

SET @IdTipoComprobanteFacturaVenta=(Select IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 (
			 A_IdComprobante INTEGER,
			 K_IdTipoComprobante INTEGER,
			 K_Fecha DATETIME,
			 K_Registro INTEGER,
			 K_PuntoVenta INTEGER,
			 K_TipoComprobanteAFIP INTEGER,
			 K_Numero INTEGER,
			 K_IdIdentificacionCAE INTEGER,
			 A_Fecha DATETIME,
			 A_Comprobante VARCHAR(20),
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(50),
			 A_TotalGravado NUMERIC(18, 2),
			 A_TotalNoGravado NUMERIC(18, 2),
			 A_TotalSinImpuestos NUMERIC(18, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Retenciones NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	Fac.IdFactura,
	@IdTipoComprobanteFacturaVenta,
	Fac.FechaFactura,
	1,
	Fac.PuntoVenta,
	Case When Fac.TipoABC='A' Then 1 Else 6 End,
	Fac.NumeroFactura,
	IsNull(Fac.IdIdentificacionCAE,0),
	Fac.FechaFactura,
	'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura),
	Cli.Codigo,
	Cli.RazonSocial,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
			IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0
		 Then 0
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
			IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End,
	Case 	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
		Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)
	End,
	0,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
			IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
		 Then 0
		Else (Fac.ImporteIva1 + Fac.ImporteIva2) * Fac.CotizacionMoneda
	End,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * Fac.CotizacionMoneda,
	Fac.ImporteTotal * Fac.CotizacionMoneda
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN PuntosVenta ON PuntosVenta.IdPuntoVenta=Fac.IdPuntoVenta
 WHERE (Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta)) and IsNull(Fac.Anulada,'')<>'SI' and 
	IsNull(PuntosVenta.WebService,'')='WSBFE' and IsNull(WebServiceModoTest,'')<>'SI'


UPDATE #Auxiliar1
SET A_TotalGravado=0
WHERE A_TotalGravado IS NULL

UPDATE #Auxiliar1
SET A_TotalNoGravado=0
WHERE A_TotalNoGravado IS NULL

UPDATE #Auxiliar1
SET A_TotalSinImpuestos=A_TotalGravado+A_TotalNoGravado

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000000001111111133'
SET @vector_T='000000006411533400'

SELECT 
	A_IdComprobante as [A_IdComprobante],
	K_IdTipoComprobante as [K_IdTipoComprobante],
	K_Fecha as [K_Fecha],
	1 as [K_Orden],
	K_PuntoVenta as [K_PuntoVenta],
	K_TipoComprobanteAFIP as [K_TipoComprobanteAFIP],
	K_Numero as [K_Numero],
	K_IdIdentificacionCAE as [K_IdIdentificacionCAE],
	A_Comprobante as [Comprobante],
	A_Fecha as [Fecha],
	A_CodigoCliente as [Codigo],
	A_Cliente as [Cliente],
	A_TotalSinImpuestos as [Total s/impuestos],
	A_Iva as [IVA],
	A_Retenciones as [Otros],
	A_Total as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
ORDER BY [K_Fecha],[K_IdTipoComprobante],[A_IdComprobante],[K_Orden]

DROP TABLE #Auxiliar1