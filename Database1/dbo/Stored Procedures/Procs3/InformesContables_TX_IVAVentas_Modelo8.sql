CREATE PROCEDURE [dbo].[InformesContables_TX_IVAVentas_Modelo8]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 
			(
			 Tipo VARCHAR(2),
			 IdComprobante INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT 
  'FA',
  dfoc.IdFactura,
  OrdenesCompra.IdObra
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura = dfoc.IdFactura
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE OrdenesCompra.IdObra is not null and 
	(Fac.Anulada is null or Fac.Anulada<>'SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

 UNION ALL

 SELECT 
  'FA',
  DetFacRem.IdFactura,
  DetalleRemitos.IdObra
 FROM DetalleFacturasRemitos DetFacRem
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura = DetFacRem.IdFactura
 LEFT OUTER JOIN DetalleRemitos ON DetFacRem.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
 WHERE DetalleRemitos.IdObra is not null and 
	(Fac.Anulada is null or Fac.Anulada<>'SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

 UNION ALL

 SELECT 
  'CD',
  DetDev.IdDevolucion,
  DetDev.IdObra
 FROM DetalleDevoluciones DetDev
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion = DetDev.IdDevolucion
 WHERE DetDev.IdObra is not null and 
	(Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI')

 UNION ALL

 SELECT 
  'ND',
  Deb.IdNotaDebito,
  Deb.IdObra
 FROM NotasDebito Deb
 WHERE Deb.IdObra is not null and 
	(Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and
	(Deb.Anulada is null or Deb.Anulada<>'SI') and 
	Deb.CtaCte='SI' and 
	Deb.IdNotaCreditoVenta_RecuperoGastos is null

 UNION ALL

 SELECT 
  'NC',
  Cre.IdNotaCredito,
  OrdenesCompra.IdObra
 FROM DetalleNotasCreditoOrdenesCompra dcoc
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito = dcoc.IdNotaCredito
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dcoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE OrdenesCompra.IdObra is not null and 
	(Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and 
	Cre.CtaCte='SI' and 
	Cre.IdFacturaVenta_RecuperoGastos is null

CREATE TABLE #Auxiliar1 
			(
			 Tipo VARCHAR(2),
			 IdComprobante INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Tipo,
  IdComprobante,
  MAX(IdObra)
 FROM #Auxiliar0
 GROUP BY Tipo,IdComprobante

CREATE TABLE #Auxiliar 
			(
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(3),
			 A_Comprobante VARCHAR(20),
			 A_Cuenta INTEGER,
			 A_Cliente VARCHAR(100),
			 A_CondicionIVA VARCHAR(50),
			 A_Cuit VARCHAR(13),
			 A_NetoGravado NUMERIC(18, 2),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_Tasa NUMERIC(6, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Percepcion NUMERIC(18, 2),
			 A_PercepcionIVA NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2),
			 A_IdObra INTEGER,
			 A_Comprobante1 VARCHAR(20)
			)
INSERT INTO #Auxiliar 

 SELECT 
	Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End,
	'1FA',
	Case When IsNull(Fac.CuentaVentaNumero,0)=0 
		Then 'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura)
		Else 'CV '+IsNull(Fac.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.CuentaVentaPuntoVenta)))+Convert(varchar,Fac.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Fac.CuentaVentaNumero)))+Convert(varchar,Fac.CuentaVentaNumero)
	End,
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - 
			IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.AjusteIva,0) - IsNull(Fac.PercepcionIVA,0)) / 
			(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or 
			(Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0)
		 Then 0
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) -IsNull(Fac.AjusteIva,0) - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End,
	Case 	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or 
			(Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0)
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 -IsNull(Fac.AjusteIva,0) - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
		Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)
	End,
	Case 	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else Fac.PorcentajeIva1
	End,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
		 Then ((Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
			IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) + IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or 
			(Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0)
		 Then 0
		Else (Fac.ImporteIva1 + Fac.ImporteIva2 +IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
	End,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * Fac.CotizacionMoneda,
	IsNull(Fac.PercepcionIVA,0) * Fac.CotizacionMoneda,
	Fac.ImporteTotal * Fac.CotizacionMoneda,
	#Auxiliar1.IdObra,
	Case When IsNull(Fac.CuentaVentaNumero,0)=0 
		Then Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura)
		Else IsNull(Fac.CuentaVentaLetra,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.CuentaVentaPuntoVenta)))+Convert(varchar,Fac.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Fac.CuentaVentaNumero)))+Convert(varchar,Fac.CuentaVentaNumero)
	End
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='FA' and #Auxiliar1.IdComprobante=Fac.IdFactura
 WHERE (Fac.Anulada is null or Fac.Anulada<>'SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

UNION ALL 

 SELECT 
	Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End,
	'1FA',
	Case When IsNull(Fac.CuentaVentaNumero,0)=0 
		Then 'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura)
		Else 'CV '+IsNull(Fac.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.CuentaVentaPuntoVenta)))+Convert(varchar,Fac.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Fac.CuentaVentaNumero)))+Convert(varchar,Fac.CuentaVentaNumero)
	End,
	Null,
	'FACTURA ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Case When IsNull(Fac.CuentaVentaNumero,0)=0 
		Then Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura)
		Else IsNull(Fac.CuentaVentaLetra,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.CuentaVentaPuntoVenta)))+Convert(varchar,Fac.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Fac.CuentaVentaNumero)))+Convert(varchar,Fac.CuentaVentaNumero)
	End
 FROM Facturas Fac 
 WHERE (Fac.Anulada is not null and Fac.Anulada='SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

UNION ALL 

 SELECT 
	Dev.FechaDevolucion,
	'2CD',
	'DEV '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1
	End,
	Case 	When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1
		Else 0
	End,
	Case 	When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else Dev.PorcentajeIva1
	End,
	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1/100) * Dev.CotizacionMoneda * -1
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * -1
	End,
	(Dev.RetencionIBrutos1 + Dev.RetencionIBrutos2 + Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1,
	0,
	Dev.ImporteTotal * Dev.CotizacionMoneda * -1,
	#Auxiliar1.IdObra,
	Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion)
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='CD' and #Auxiliar1.IdComprobante=Dev.IdDevolucion
 WHERE (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and (Dev.Anulada is null or Dev.Anulada<>'SI')

UNION ALL 

 SELECT 
	Dev.FechaDevolucion,
	'2CD',
	'DEV '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	Null,
	'DEVOLUCION ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion)
 FROM Devoluciones Dev 
 WHERE (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and 
	(Dev.Anulada is not null and Dev.Anulada='SI')

UNION ALL 

 SELECT 
	Deb.FechaNotaDebito,
	'3ND',
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito),
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * Deb.CotizacionMoneda
	End,
	Case 	When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
		Else (IsNull((Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado<>'SI'),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
	End,
	Case 	When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else Deb.PorcentajeIva1
	End,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / (1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
	End,
	(IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda,
	IsNull(Deb.PercepcionIVA,0) * Deb.CotizacionMoneda,
	Deb.ImporteTotal * Deb.CotizacionMoneda,
	#Auxiliar1.IdObra,
	Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito)
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='ND' and #Auxiliar1.IdComprobante=Deb.IdNotaDebito
 WHERE (Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and
	(Deb.Anulada is null or Deb.Anulada<>'SI') and Deb.CtaCte='SI' and Deb.IdNotaCreditoVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Deb.FechaNotaDebito,
	'3ND',
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito),
	Null,
	'NOTA DE DEBITO ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito)
 FROM NotasDebito Deb 
 WHERE (Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Deb.Anulada is not null and Deb.Anulada='SI') and Deb.CtaCte='SI' and Deb.IdNotaCreditoVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Cre.FechaNotaCredito,
	'4NC',
	Case When IsNull(Cre.CuentaVentaNumero,0)=0 
		Then 'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito)
		Else 'CV '+IsNull(Cre.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.CuentaVentaPuntoVenta)))+Convert(varchar,Cre.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Cre.CuentaVentaNumero)))+Convert(varchar,Cre.CuentaVentaNumero)
	End,
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * Cre.CotizacionMoneda * -1
	End,
	Case 	When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda * -1
		Else (IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado<>'SI'),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda * -1
	End,
	Case When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		Then 0
		Else Cre.PorcentajeIva1
	End,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * Cre.CotizacionMoneda * -1
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda * -1
	End,
	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1,
	IsNull(Cre.PercepcionIVA,0) * Cre.CotizacionMoneda * -1,
	Cre.ImporteTotal * Cre.CotizacionMoneda * -1,
	#Auxiliar1.IdObra,
	Case When IsNull(Cre.CuentaVentaNumero,0)=0 
		Then Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito)
		Else IsNull(Cre.CuentaVentaLetra,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.CuentaVentaPuntoVenta)))+Convert(varchar,Cre.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Cre.CuentaVentaNumero)))+Convert(varchar,Cre.CuentaVentaNumero)
	End
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='NC' and #Auxiliar1.IdComprobante=Cre.IdNotaCredito
 WHERE (Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and Cre.CtaCte='SI' and Cre.IdFacturaVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Cre.FechaNotaCredito,
	'4NC',
	Case When IsNull(Cre.CuentaVentaNumero,0)=0 
		Then 'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito)
		Else 'CV '+IsNull(Cre.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.CuentaVentaPuntoVenta)))+Convert(varchar,Cre.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Cre.CuentaVentaNumero)))+Convert(varchar,Cre.CuentaVentaNumero)
	End,
	Null,
	'NOTA DE CREDITO ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Case When IsNull(Cre.CuentaVentaNumero,0)=0 
		Then Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito)
		Else IsNull(Cre.CuentaVentaLetra,'')+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.CuentaVentaPuntoVenta)))+Convert(varchar,Cre.CuentaVentaPuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,Cre.CuentaVentaNumero)))+Convert(varchar,Cre.CuentaVentaNumero)
	End
 FROM NotasCredito Cre 
 WHERE (Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Cre.Anulada is not null and Cre.Anulada='SI') and Cre.CtaCte='SI' and Cre.IdFacturaVenta_RecuperoGastos is null

UPDATE #Auxiliar
SET A_NetoGravado=0
WHERE A_NetoGravado IS NULL

UPDATE #Auxiliar
SET A_NetoNoGravado=0
WHERE A_NetoNoGravado IS NULL

UPDATE #Auxiliar
SET A_Iva=0
WHERE A_Iva IS NULL

UPDATE #Auxiliar
SET A_Percepcion=0
WHERE A_Percepcion IS NULL

UPDATE #Auxiliar
SET A_Total=0
WHERE A_Total IS NULL

SET NOCOUNT OFF

Declare @vector_X varchar(50), @vector_T varchar(50), @vector_E varchar(500)
Set @vector_X='0000111111116616666133'
Set @vector_T='0000947262153303333900'
Set @vector_E=' ANC:10,FON:8,CEN | ANC:16,FON:8,CEN | ANC:10,FON:8,CEN |'+
		' ANC:10,FON:8,CEN | ANC:35,FON:8,LEF | ANC:18,FON:8,CEN |'+
		' ANC:13,FON:8,CEN | ANC:10,FON:8,NUM:#COMMA##0.00 |'+
		' ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:6,FON:8,NUM:#COMMA##0.00 |'+
		' ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 |'+
		' ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:12,FON:8,NUM:#COMMA##0.00 |'

SELECT 
 0 as [IdReg],
 1 as [Agrupacion],
 A_TipoComprobante as [Tipo],
 A_Comprobante1 as [Comprobante1],
 Null as [.],
 A_Fecha as [Fecha],
 A_Comprobante as [Comprobante],
 A_Cuenta as [Cuenta],
 Obras.NumeroObra as [Obra],
 A_Cliente as [Cliente],
 A_CondicionIVA as [Condicion],
 A_Cuit as [CUIT],
 Case When A_NetoGravado<>0 then A_NetoGravado Else Null End as [Gravado],
 Case When A_NetoNoGravado<>0 then A_NetoNoGravado Else Null End as [No gravado],
 A_Tasa as [Tasa],
 Case When A_Iva<>0 then A_Iva Else Null End as [IVA],
 Case When A_PercepcionIVA<>0 then A_PercepcionIVA Else Null End as [Perc.IVA],
 Case When A_Percepcion<>0 then A_Percepcion Else Null End as [Perc.I.B.],
 Case When A_Total<>0 then A_Total Else Null End as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar.A_IdObra

UNION ALL 
/*
SELECT 
 0 as [IdReg],
 2 as [Agrupacion],
 A_TipoComprobante as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL TIPO COMPROBANTE' as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 SUM(A_NetoGravado) as [Gravado],
 SUM(A_NetoNoGravado) as [No gravado],
 Null as [Tasa],
 SUM(A_Iva) as [IVA],
 SUM(A_Percepcion) as [Perc.I.B.],
 SUM(A_Total) as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
GROUP BY A_TipoComprobante

UNION ALL 

SELECT 
 0 as [IdReg],
 3 as [Agrupacion],
 A_TipoComprobante as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 Null as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado],
 Null as [No gravado],
 Null as [Tasa],
 Null as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
GROUP BY A_TipoComprobante
UNION ALL 
*/
SELECT 
 0 as [IdReg],
 4 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL GENERAL' as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 SUM(A_NetoGravado) as [Gravado],
 SUM(A_NetoNoGravado) as [No gravado],
 Null as [Tasa],
 SUM(A_Iva) as [IVA],
 SUM(A_PercepcionIVA) as [Perc.IVA],
 SUM(A_Percepcion) as [Perc.I.B.],
 SUM(A_Total) as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 

UNION ALL 

SELECT 
 0 as [IdReg],
 5 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 Null as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado],
 Null as [No gravado],
 Null as [Tasa],
 Null as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [Total compr.],
 'FinTransporte' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT 
 0 as [IdReg],
 6 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL IVA '+CONVERT(VARCHAR,A_Tasa)+'%' as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 SUM(A_NetoGravado) as [Gravado],
 Null as [No gravado],
 A_Tasa as [Tasa],
 SUM(A_Iva) as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
WHERE A_Iva<>0
GROUP BY A_Tasa
UNION ALL 

SELECT 
 0 as [IdReg],
 7 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 Null as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado],
 Null as [No gravado],
 Null as [Tasa],
 Null as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT 
 0 as [IdReg],
 8 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL '+A_CondicionIVA as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 SUM(A_NetoGravado) as [Gravado],
 Null as [No gravado],
 Null as [Tasa],
 SUM(A_Iva) as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
WHERE A_Iva<>0
GROUP BY A_CondicionIVA
/*
UNION ALL 

SELECT 
 0 as [IdReg],
 9 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 Null as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado], Null as [No gravado],
 Null as [Tasa],
 Null as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT 
 0 as [IdReg],
 10 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL CONTROL IVA' as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado],
 Null as [No gravado],
 Null as [Tasa],
 SUM(A_Iva) as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [Total compr.],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
*/
ORDER By [Agrupacion],[Fecha],[Comprobante1],[Tipo]

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1