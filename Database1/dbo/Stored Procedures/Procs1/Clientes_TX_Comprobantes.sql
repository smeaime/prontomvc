CREATE Procedure [dbo].[Clientes_TX_Comprobantes]

@Desde datetime,
@Hasta datetime,
@TipoConsulta varchar(1) = Null

AS 

SET NOCOUNT ON

SET @TipoConsulta=IsNull(@TipoConsulta,'D')

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
	@IdTipoComprobanteNotaCredito int
SET @IdTipoComprobanteFacturaVenta=(Select IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 (
			 A_IdComprobante INTEGER,
			 K_IdTipoComprobante INTEGER,
			 K_Fecha DATETIME,
			 K_Registro INTEGER,
			 A_Fecha DATETIME,
			 A_Comprobante VARCHAR(20),
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(50),
			 A_TotalGravado NUMERIC(18, 2),
			 A_TotalNoGravado NUMERIC(18, 2),
			 A_TotalSinImpuestos NUMERIC(18, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Retenciones NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2),
			 Cuenta VARCHAR(100),
			 Debe NUMERIC(18,2),
			 Haber NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	Fac.IdFactura,
	@IdTipoComprobanteFacturaVenta,
	Fac.FechaFactura,
	1,
	Fac.FechaFactura,
	'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+
		Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+
		Convert(varchar,Fac.NumeroFactura),
	Cli.Codigo,
	Cli.RazonSocial,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
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
		Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)
	End,
	0,
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
	Fac.ImporteTotal * Fac.CotizacionMoneda,
	Null,
	0,
	0
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE (Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta)) and 
	(Fac.Anulada is null or Fac.Anulada<>'SI') 

UNION ALL 

 SELECT  
	Subdiarios.IdComprobante,
	@IdTipoComprobanteFacturaVenta,
	Fac.FechaFactura,
	2,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Convert(varchar,Cuentas.Codigo)+'  '+Cuentas.Descripcion,
	Case When Subdiarios.Debe is not null Then Subdiarios.Debe Else 0 End,
	Case When Subdiarios.Haber is not null Then Subdiarios.Haber Else 0 End
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Subdiarios.IdCuenta
 LEFT OUTER JOIN Facturas Fac ON Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta and 
				 Subdiarios.IdComprobante=Fac.IdFactura
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE (Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta)) and 
	(Fac.Anulada is null or Fac.Anulada<>'SI') 

UNION ALL 

 SELECT  
	Dev.IdDevolucion,
	@IdTipoComprobanteDevoluciones,
	Dev.FechaDevolucion,
	1,
	Dev.FechaDevolucion,
	'DEV '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+
		Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+
		Convert(varchar,Dev.NumeroDevolucion),
	Cli.Codigo,
	Cli.RazonSocial,
	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
			Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - 
			Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - 
			Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1
	End,
	Case 	When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - 
			Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - 
			Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1
		Else 0
	End,
	0,
	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
			Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1/100) * 
			Dev.CotizacionMoneda * -1
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * -1
	End,
	(Dev.RetencionIBrutos1 + Dev.RetencionIBrutos2 + Dev.RetencionIBrutos3) * 
		Dev.CotizacionMoneda * -1,
	Dev.ImporteTotal * Dev.CotizacionMoneda * -1,
	Null,
	0,
	0
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI') 

UNION ALL 

 SELECT  
	Subdiarios.IdComprobante,
	@IdTipoComprobanteDevoluciones,
	Dev.FechaDevolucion,
	2,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Convert(varchar,Cuentas.Codigo)+'  '+Cuentas.Descripcion,
	Case When Subdiarios.Debe is not null Then Subdiarios.Debe Else 0 End,
	Case When Subdiarios.Haber is not null Then Subdiarios.Haber Else 0 End
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Subdiarios.IdCuenta
 LEFT OUTER JOIN Devoluciones Dev ON Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones and 
				 	Subdiarios.IdComprobante=Dev.IdDevolucion
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI') 

UNION ALL 

 SELECT  
	Deb.IdNotaDebito,
	@IdTipoComprobanteNotaDebito,
	Deb.FechaNotaDebito,
	1,
	Deb.FechaNotaDebito,
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+
		Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+
		Convert(varchar,Deb.NumeroNotaDebito),
	Cli.Codigo,
	Cli.RazonSocial,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * 
			 Deb.CotizacionMoneda
	End,
	Case 	When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
				Where DetND.IdNotaDebito=Deb.IdNotaDebito),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + 
			IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
		Else (IsNull((Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
				Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado<>'SI'),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + 
			IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
	End,
	0,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
	End,
	(IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda,
	Deb.ImporteTotal * Deb.CotizacionMoneda,
	Null,
	0,
	0
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE (Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Deb.Anulada is null or Deb.Anulada<>'SI') and IsNull(Deb.AplicarEnCtaCte,'SI')='SI'

UNION ALL 

 SELECT  
	Subdiarios.IdComprobante,
	@IdTipoComprobanteNotaDebito,
	Deb.FechaNotaDebito,
	2,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Convert(varchar,Cuentas.Codigo)+'  '+Cuentas.Descripcion,
	Case When Subdiarios.Debe is not null Then Subdiarios.Debe Else 0 End,
	Case When Subdiarios.Haber is not null Then Subdiarios.Haber Else 0 End
 FROM Subdiarios  
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Subdiarios.IdCuenta
 LEFT OUTER JOIN NotasDebito Deb ON Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito and 
				 	Subdiarios.IdComprobante=Deb.IdNotaDebito
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE (Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Deb.Anulada is null or Deb.Anulada<>'SI') and IsNull(Deb.AplicarEnCtaCte,'SI')='SI'

UNION ALL 

 SELECT 
	Cre.IdNotaCredito,
	@IdTipoComprobanteNotaCredito,
	Cre.FechaNotaCredito,
	1,
	Cre.FechaNotaCredito,
	'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+
		Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+
		Convert(varchar,Cre.NumeroNotaCredito),
	Cli.Codigo,
	Cli.RazonSocial,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * 
			Cre.CotizacionMoneda * -1
	End,
	Case 	When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
				Where DetNC.IdNotaCredito=Cre.IdNotaCredito),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + 
			IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda * -1
		Else (IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
				Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado<>'SI'),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + 
			IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda * -1
	End,
	0,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * 
			Cre.CotizacionMoneda * -1
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda * -1
	End,
	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1,
	Cre.ImporteTotal * Cre.CotizacionMoneda * -1,
	Null,
	0,
	0
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE (Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and IsNull(Cre.AplicarEnCtaCte,'SI')='SI'

UNION ALL 

 SELECT  
	Subdiarios.IdComprobante,
	@IdTipoComprobanteNotaCredito,
	Cre.FechaNotaCredito,
	2,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Convert(varchar,Cuentas.Codigo)+'  '+Cuentas.Descripcion,
	Case When Subdiarios.Debe is not null Then Subdiarios.Debe Else 0 End,
	Case When Subdiarios.Haber is not null Then Subdiarios.Haber Else 0 End
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Subdiarios.IdCuenta
 LEFT OUTER JOIN NotasCredito Cre ON Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito and 
				 	Subdiarios.IdComprobante=Cre.IdNotaCredito
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE (Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and IsNull(Cre.AplicarEnCtaCte,'SI')='SI'

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
SET @vector_X='00001111111111133'
SET @vector_T='00006411533433300'

SELECT 
	A_IdComprobante as [A_IdComprobante],
	K_IdTipoComprobante as [K_IdTipoComprobante],
	K_Fecha as [K_Fecha],
	1 as [K_Orden],
	A_Comprobante as [Comprobante],
	A_Fecha as [Fecha],
	A_CodigoCliente as [Codigo],
	A_Cliente as [Cliente],
	A_TotalSinImpuestos as [Total s/impuestos],
	A_Iva as [IVA],
	A_Retenciones as [Otros],
	A_Total as [Total general],
	Null as [Cuenta],
	Null as [Debe],
	Null as [Haber],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE K_Registro=1

UNION ALL 

SELECT 
	A_IdComprobante as [A_IdComprobante],
	K_IdTipoComprobante as [K_IdTipoComprobante],
	K_Fecha as [K_Fecha],
	2 as [K_Orden],
	Null as [Comprobante],
	Null as [Fecha],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Total s/impuestos],
	Null as [IVA],
	Null as [Otros],
	Null as [Total general],
	Cuenta as [Cuenta],
	Case When Debe<>0 Then Debe Else Null End as [Debe],
	Case When Haber<>0 Then Haber Else Null End as [Haber],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE K_Registro=2

UNION ALL 

SELECT 
	A_IdComprobante as [A_IdComprobante],
	K_IdTipoComprobante as [K_IdTipoComprobante],
	K_Fecha as [K_Fecha],
	3 as [K_Orden],
	Null as [Comprobante],
	Null as [Fecha],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Total s/impuestos],
	Null as [IVA],
	Null as [Otros],
	Null as [Total general],
	SPACE(30)+'TOTALES' as [Cuenta],
	SUM(Debe) as [Debe],
	SUM(Haber) as [Haber],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY A_IdComprobante,K_IdTipoComprobante,K_Fecha

UNION ALL 

SELECT 
	A_IdComprobante as [A_IdComprobante],
	K_IdTipoComprobante as [K_IdTipoComprobante],
	K_Fecha as [K_Fecha],
	4 as [K_Orden],
	Null as [Comprobante],
	Null as [Fecha],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Total s/impuestos],
	Null as [IVA],
	Null as [Otros],
	Null as [Total general],
	Null as [Cuenta],
	Null as [Debe],
	Null as [Haber],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY A_IdComprobante,K_IdTipoComprobante,K_Fecha

ORDER BY [K_Fecha],[K_IdTipoComprobante],[A_IdComprobante],[K_Orden]

DROP TABLE #Auxiliar1