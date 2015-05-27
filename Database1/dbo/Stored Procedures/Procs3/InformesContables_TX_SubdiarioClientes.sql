
CREATE PROCEDURE [dbo].[InformesContables_TX_SubdiarioClientes]

@FechaDesde datetime,
@FechaHasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 A_IdComprobante INTEGER,
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(3),
			 A_Comprobante VARCHAR(20),
			 A_Cliente VARCHAR(50),
			 A_Cuit VARCHAR(13),
			 A_NetoGravado NUMERIC(18, 2),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_Tasa NUMERIC(6, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Percepcion NUMERIC(18, 2),
			 A_PercepcionIVA NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	Fac.IdFactura,
	Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End,
	'1FA',
	Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+
		Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+
		Convert(varchar,Fac.NumeroFactura),
	Cli.RazonSocial,
	Cli.Cuit,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and 
			Fac.PorcentajeIva1<>0
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - 
			Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / 
			(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0
		 Then 0
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - 
			Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - 
			IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
			IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End,
	Case 	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - 
			Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
		Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + 
			IsNull(Fac.OtrasPercepciones3,0)
	End,
	Case 	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else Fac.PorcentajeIva1
	End,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - 
			Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / 
			(1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
		 Then 0
		Else (Fac.ImporteIva1 + Fac.ImporteIva2) * Fac.CotizacionMoneda
	End,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * Fac.CotizacionMoneda,
	IsNull(Fac.PercepcionIVA,0) * Fac.CotizacionMoneda,
	Fac.ImporteTotal * Fac.CotizacionMoneda
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE (Fac.Anulada is null or Fac.Anulada<>'SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @FechaDesde and DATEADD(n,1439,@FechaHasta))

UNION ALL 

 SELECT 
	Fac.IdFactura,
	Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End,
	'1FA',
	Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+
		Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+
		Convert(varchar,Fac.NumeroFactura),
	'FACTURA ANULADA',
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0
 FROM Facturas Fac 
 WHERE (Fac.Anulada is not null and Fac.Anulada='SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @FechaDesde and DATEADD(n,1439,@FechaHasta))

UNION ALL 

 SELECT 
	Dev.IdDevolucion,
	Dev.FechaDevolucion,
	'2CD',
	Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+
		Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+
		Convert(varchar,Dev.NumeroDevolucion),
	Cli.RazonSocial,
	Cli.Cuit,
	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
			Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - 
			Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - 
			Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1
	End,
	Case 	When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - 
			Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - 
			Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1
		Else 0
	End,
	Case 	When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else Dev.PorcentajeIva1
	End,
	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
			Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1/100) * 
			Dev.CotizacionMoneda * -1
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * -1
	End,
	(Dev.RetencionIBrutos1 + Dev.RetencionIBrutos2 + Dev.RetencionIBrutos3) * 
		Dev.CotizacionMoneda * -1,
	0,
	Dev.ImporteTotal * Dev.CotizacionMoneda * -1
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE (Dev.FechaDevolucion between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI')

UNION ALL 

 SELECT 
	Dev.IdDevolucion,
	Dev.FechaDevolucion,
	'2CD',
	Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+
		Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+
		Convert(varchar,Dev.NumeroDevolucion),
	'DEVOLUCION ANULADA',
	Null,
	0,
	0,
	0,
	0,	0,
	0,	0
 FROM Devoluciones Dev 
 WHERE (Dev.FechaDevolucion between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Dev.Anulada is not null and Dev.Anulada='SI')

UNION ALL 

 SELECT 
	Deb.IdNotaDebito,
	Deb.FechaNotaDebito,
	Case When IsNull(Deb.CtaCte,'SI')='SI' Then '3ND' Else '3DI' End,
	Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+
		Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+
		Convert(varchar,Deb.NumeroNotaDebito),
	Cli.RazonSocial,
	Cli.Cuit,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * 
			 Deb.CotizacionMoneda
	End,
	Case 	When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND
				Where DetND.IdNotaDebito=Deb.IdNotaDebito),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + 
			IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
		Else (IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND
				Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado<>'SI'),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + 
			IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
	End,
	Case 	When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else Deb.PorcentajeIva1
	End,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
	End,
	(IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda,
	IsNull(Deb.PercepcionIVA,0) * Deb.CotizacionMoneda,
	Deb.ImporteTotal * Deb.CotizacionMoneda
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE (Deb.FechaNotaDebito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and
	(Deb.Anulada is null or Deb.Anulada<>'SI') and 
	Deb.IdNotaCreditoVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Deb.IdNotaDebito,
	Deb.FechaNotaDebito,
	Case When IsNull(Deb.CtaCte,'SI')='SI' Then '3ND' Else '3DI' End,
	Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+
		Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+
		Convert(varchar,Deb.NumeroNotaDebito),
	'NOTA DE DEBITO ANULADA',
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0
 FROM NotasDebito Deb 
 WHERE (Deb.FechaNotaDebito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Deb.Anulada is not null and Deb.Anulada='SI') and 
	Deb.IdNotaCreditoVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Cre.IdNotaCredito,
	Cre.FechaNotaCredito,
	Case When IsNull(Cre.CtaCte,'SI')='SI' Then '4NC' Else '4CI' End,
	Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+
		Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+
		Convert(varchar,Cre.NumeroNotaCredito),
	Cli.RazonSocial,
	Cli.Cuit,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * 
			Cre.CotizacionMoneda * -1
	End,
	Case 	When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
				Where DetNC.IdNotaCredito=Cre.IdNotaCredito),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + 
			IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda * -1
		Else (IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
				Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado<>'SI'),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + 
			IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda * -1
	End,
	Case When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		Then 0
		Else Cre.PorcentajeIva1
	End,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * 
			Cre.CotizacionMoneda * -1
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda * -1
	End,
	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1,
	IsNull(Cre.PercepcionIVA,0) * Cre.CotizacionMoneda * -1,
	Cre.ImporteTotal * Cre.CotizacionMoneda * -1
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE (Cre.FechaNotaCredito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and 
	Cre.IdFacturaVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Cre.IdNotaCredito,
	Cre.FechaNotaCredito,
	Case When IsNull(Cre.CtaCte,'SI')='SI' Then '4NC' Else '4CI' End,
	Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+
		Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+
		Convert(varchar,Cre.NumeroNotaCredito),
	'NOTA DE CREDITO ANULADA',
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0
 FROM NotasCredito Cre 
 WHERE (Cre.FechaNotaCredito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Cre.Anulada is not null and Cre.Anulada='SI') and 
	Cre.IdFacturaVenta_RecuperoGastos is null

UPDATE #Auxiliar1
SET A_NetoGravado=0
WHERE A_NetoGravado IS NULL

UPDATE #Auxiliar1
SET A_NetoNoGravado=0
WHERE A_NetoNoGravado IS NULL

UPDATE #Auxiliar1
SET A_Iva=0
WHERE A_Iva IS NULL

UPDATE #Auxiliar1
SET A_Percepcion=0
WHERE A_Percepcion IS NULL

UPDATE #Auxiliar1
SET A_Total=0
WHERE A_Total IS NULL


CREATE TABLE #Auxiliar2
			(
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(3),
			 A_IdComprobante INTEGER,
			 A_Comprobante VARCHAR(20),
			 A_Cliente VARCHAR(50),
			 A_Cuit VARCHAR(13),
			 A_NetoGravado NUMERIC(18, 2),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_Tasa NUMERIC(6, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Percepcion NUMERIC(18, 2),
			 A_PercepcionIVA NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT A_Fecha, A_TipoComprobante, A_IdComprobante, A_Comprobante, A_Cliente, A_Cuit, 
	Sum(IsNull(A_NetoGravado,0)), Sum(IsNull(A_NetoNoGravado,0)), A_Tasa, 
	Sum(IsNull(A_Iva,0)), Sum(IsNull(A_Percepcion,0)), Sum(IsNull(A_PercepcionIVA,0)), 
	Sum(IsNull(A_Total,0))
 FROM #Auxiliar1
/*
 WHERE IsNull(A_NetoGravado,0)<>0 or IsNull(A_NetoNoGravado,0)<>0 or 
	IsNull(A_Iva,0)<>0 or IsNull(A_Percepcion,0)<>0  or IsNull(A_PercepcionIVA,0)<>0 
*/
 GROUP BY A_Fecha, A_TipoComprobante, A_IdComprobante, A_Tasa, A_Comprobante, A_Cliente, A_Cuit

CREATE TABLE #Auxiliar3 
			(
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(3),
			 A_IdComprobante INTEGER,
			 A_Comprobante VARCHAR(20),
			 A_Cliente VARCHAR(50),
			 A_Cuit VARCHAR(13),
			 A_NetoGravado NUMERIC(18, 2),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Percepcion NUMERIC(18, 2),
			 A_PercepcionIVA NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT A_Fecha, A_TipoComprobante, A_IdComprobante, A_Comprobante, A_Cliente, A_Cuit, 
	Sum(IsNull(A_NetoGravado,0)), Sum(IsNull(A_NetoNoGravado,0)), Sum(IsNull(A_Iva,0)), 
	Sum(IsNull(A_Percepcion,0)), Sum(IsNull(A_PercepcionIVA,0)), Sum(IsNull(A_Total,0))
 FROM #Auxiliar2
/*
 WHERE IsNull(A_NetoGravado,0)<>0 or IsNull(A_NetoNoGravado,0)<>0 or 
	IsNull(A_Iva,0)<>0 or IsNull(A_Percepcion,0)<>0  or IsNull(A_PercepcionIVA,0)<>0 
*/
 GROUP BY A_Fecha, A_TipoComprobante, A_IdComprobante, A_Comprobante, A_Cliente, A_Cuit

SET NOCOUNT OFF

Declare @vector_X varchar(40),@vector_T varchar(40),@vector_E varchar(500)
Set @vector_X='00000111116166133'
Set @vector_T='00000425130533900'
Set @vector_E='  '

SELECT 
 0 as [IdAux1],
 0 as [IdAux2],
 #Auxiliar3.A_Fecha as [IdAux3],
 '' as [IdAux4],
 1 as [IdAux5],
 #Auxiliar3.A_Fecha as [Fecha],
 Null as [Cod.Com.],
 Null as [N.Comprobante],
 Null as [Cliente],
 Null as [Razon Social],
 Null as [Imp.IVA], 
 Null as [Nro.CUIT], 
 Null as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 ' FEC |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
GROUP BY #Auxiliar3.A_Fecha

UNION ALL

SELECT 
 #Auxiliar3.A_IdComprobante as [IdAux1],
 0 as [IdAux2],
 #Auxiliar3.A_Fecha as [IdAux3],
 Substring(#Auxiliar3.A_TipoComprobante,2,3)+#Auxiliar3.A_Comprobante as [IdAux4],
 2 as [IdAux5],
 Null as [Fecha],
 Substring(#Auxiliar3.A_TipoComprobante,2,3) as [Cod.Com.],
 #Auxiliar3.A_Comprobante as [N.Comprobante],
 Null as [Cliente],
 #Auxiliar3.A_Cliente as [Razon Social],
 Null as [Imp.IVA], 
 #Auxiliar3.A_Cuit as [Nro.CUIT], 
 Null as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 '  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3

UNION ALL

SELECT 
 #Auxiliar2.A_IdComprobante as [IdAux1],
 0 as [IdAux2],
 #Auxiliar2.A_Fecha as [IdAux3],
 Substring(#Auxiliar2.A_TipoComprobante,2,3)+#Auxiliar2.A_Comprobante as [IdAux4],
 3 as [IdAux5],
 Null as [Fecha],
 Null as [Cod.Com.],
 Null as [N.Comprobante],
 Convert(varchar,#Auxiliar2.A_NetoGravado) as [Cliente],
 Convert(varchar,#Auxiliar2.A_Tasa) as [Razon Social],
 Convert(varchar,#Auxiliar2.A_IVA) as [Imp.IVA], 
 Null as [Nro.CUIT], 
 #Auxiliar2.A_NetoNoGravado + #Auxiliar2.A_Percepcion + #Auxiliar2.A_PercepcionIVA as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 '  |  |  | RIG,NUM:#COMMA##0.00 | CEN,NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 |  |'+
	' NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

UNION ALL

SELECT 
 #Auxiliar3.A_IdComprobante as [IdAux1],
 0 as [IdAux2],
 #Auxiliar3.A_Fecha as [IdAux3],
 Substring(#Auxiliar3.A_TipoComprobante,2,3)+#Auxiliar3.A_Comprobante as [IdAux4],
 4 as [IdAux5],
 Null as [Fecha],
 'Tot.Comp.' as [Cod.Com.],
 Convert(varchar,(#Auxiliar3.A_NetoGravado + #Auxiliar3.A_IVA + #Auxiliar3.A_NetoNoGravado + 
		  #Auxiliar3.A_Percepcion + #Auxiliar3.A_PercepcionIVA)) as [N.Comprobante],
 #Auxiliar3.A_NetoGravado as [Cliente],
 Null as [Razon Social],
 Convert(varchar,#Auxiliar3.A_IVA) as [Imp.IVA], 
 Null as [Nro.CUIT], 
 #Auxiliar3.A_NetoNoGravado + #Auxiliar3.A_Percepcion + #Auxiliar3.A_PercepcionIVA as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 '  |  | RIG,NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 |  | NUM:#COMMA##0.00 |'+
	'  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3

UNION ALL

SELECT 
 #Auxiliar2.A_IdComprobante as [IdAux1],
 0 as [IdAux2],
 #Auxiliar2.A_Fecha as [IdAux3],
 Substring(#Auxiliar2.A_TipoComprobante,2,3)+#Auxiliar2.A_Comprobante as [IdAux4],
 5 as [IdAux5],
 Null as [Fecha],
 Null as [Cod.Com.],
 Null as [N.Comprobante],
 Null as [Cliente],
 Null as [Razon Social],
 Null as [Imp.IVA], 
 Null as [Nro.CUIT], 
 Null as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 @vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY #Auxiliar2.A_IdComprobante, #Auxiliar2.A_Fecha, 
	#Auxiliar2.A_TipoComprobante, #Auxiliar2.A_Comprobante

UNION ALL

SELECT 
 0 as [IdAux1],
 1 as [IdAux2],
 Null as [IdAux3],
 Null as [IdAux4],
 6 as [IdAux5],
 Null as [Fecha],
 'Totales :' as [Cod.Com.],
 Convert(varchar,Sum(#Auxiliar3.A_NetoGravado + #Auxiliar3.A_IVA + #Auxiliar3.A_NetoNoGravado + 
			#Auxiliar3.A_Percepcion + #Auxiliar3.A_PercepcionIVA)) as [N.Comprobante],
 Sum(#Auxiliar3.A_NetoGravado) as [Cliente],
 Null as [Razon Social],
 Convert(varchar,Sum(#Auxiliar3.A_IVA)) as [Imp.IVA], 
 Null as [Nro.CUIT], 
 Sum(#Auxiliar3.A_NetoNoGravado + #Auxiliar3.A_Percepcion + 
	#Auxiliar3.A_PercepcionIVA) as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 ' EBH, CO2, AN2:4;12, AN2:5;30, '+
	'AV2:1;1, AV2:2;1, AV2:3;1, AV2:4;1, AV2:5;1, AV2:6;2, AV2:7;1, '+
	'AH2:3;1, AH2:4;1, AH2:5;1, AH2:7;1, AH2:8;1, '+
	'VAL:1;4;Cliente;     Importe;  Neto Grav., VAL:1;5;Razon Social;                    Tasa  C  Cta;                    IVA    I  Con, '+
	'VAL:1;6;Importe;I.V.A., VAL:1;7;Nro. CUIT.;     Importe;     No Insc, VAL:1;8;Importes;Exentos, VAL:1;9;Importe;Impto.Int.'+
	'  |  | RIG,NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 |  | RIG,NUM:#COMMA##0.00 |'+
	'  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3

ORDER BY [IdAux2], [IdAux3], [IdAux4], [IdAux5]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
