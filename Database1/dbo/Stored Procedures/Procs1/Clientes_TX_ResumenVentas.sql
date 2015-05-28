
CREATE Procedure [dbo].[Clientes_TX_ResumenVentas]

@FechaDesde datetime,
@FechaHasta datetime,
@CodigoDesde varchar(10),
@CodigoHasta varchar(10)

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (
			 IdComprobante INTEGER,
			 IdCliente INTEGER,
			 Codigo VARCHAR(10),
			 Cliente VARCHAR(50),
			 Fecha DATETIME,
			 Comprobante VARCHAR(25),
			 CondicionIVA VARCHAR(50),
			 Cuit VARCHAR(13),
			 TotalGravado NUMERIC(18,2),
			 TotalNoGravado NUMERIC(18,2),
			 IVA NUMERIC(18,2),
			 Retenciones NUMERIC(18,2),
			 TotalGeneral NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 

 SELECT 
	Fac.IdFactura,
	Fac.IdCliente,
	Cli.Codigo,
	Cli.RazonSocial,
	Fac.FechaFactura,
	'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+
		Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+
		Convert(varchar,Fac.NumeroFactura),
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case When Fac.TipoABC='B' 
		Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - 
			Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3) / 
			(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - 
			Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3) * Fac.CotizacionMoneda
	End,
	0,
	Case When Fac.TipoABC='B' 
		Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - 
			Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3) / 
			(1+(Fac.PorcentajeIva1/100)) * 
			(Fac.PorcentajeIva1 / 100) * Fac.CotizacionMoneda
		Else (Fac.ImporteIva1 + Fac.ImporteIva2) * Fac.CotizacionMoneda
	End,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * 
		Fac.CotizacionMoneda,
	Fac.ImporteTotal * Fac.CotizacionMoneda
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 WHERE (Fac.FechaFactura between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and
	(Fac.Anulada is null or Fac.Anulada<>'SI') and 
	Cli.Codigo>=@CodigoDesde and Cli.Codigo<=@CodigoHasta

UNION ALL 

 SELECT 
	Dev.IdDevolucion,
	Dev.IdCliente,
	Cli.Codigo,
	Cli.RazonSocial,
	Dev.FechaDevolucion,
	'DEV '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+
		Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+
		Convert(varchar,Dev.NumeroDevolucion),
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case When Dev.TipoABC='B' 
		Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
			Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - 
			Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - 
			Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * -1
	End,
	0,
	Case When Dev.TipoABC='B' 
		Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
			Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1/100) * 
			Dev.CotizacionMoneda * -1
		Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * -1
	End,
	(Dev.RetencionIBrutos1 + Dev.RetencionIBrutos2 + Dev.RetencionIBrutos3) * 
		Dev.CotizacionMoneda * -1,
	Dev.ImporteTotal * Dev.CotizacionMoneda * -1
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 WHERE Dev.FechaDevolucion between @FechaDesde and DATEADD(n,1439,@FechaHasta) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI') and 
	Cli.Codigo>=@CodigoDesde and Cli.Codigo<=@CodigoHasta

UNION ALL 

 SELECT 
	Deb.IdNotaDebito,
	Deb.IdCliente,
	Cli.Codigo,
	Cli.RazonSocial,
	Deb.FechaNotaDebito,
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+
		Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+
		Convert(varchar,Deb.NumeroNotaDebito),
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case When Deb.TipoABC='B' 
		Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		Else (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * 
			 Deb.CotizacionMoneda
	End,
	(Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
	 Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado<>'SI') * Deb.CotizacionMoneda,
	Case When Deb.TipoABC='B' 
		Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
		Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
	End,
	(IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda,
	Deb.ImporteTotal * Deb.CotizacionMoneda
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 WHERE (Deb.FechaNotaDebito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Deb.Anulada is null or Deb.Anulada<>'SI') and 
	Deb.CtaCte='SI' and Cli.Codigo>=@CodigoDesde and Cli.Codigo<=@CodigoHasta

UNION ALL 

 SELECT 
	Cre.IdNotaCredito,
	Cre.IdCliente,
	Cli.Codigo,
	Cli.RazonSocial,
	Cre.FechaNotaCredito,
	'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+
		Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+
		Convert(varchar,Cre.NumeroNotaCredito),
	DescripcionIva.Descripcion,
	Cli.Cuit,
	Case When Cre.TipoABC='B' 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
		Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * 
			Cre.CotizacionMoneda * -1
	End,
	(Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
	 Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado<>'SI') * 
		Cre.CotizacionMoneda * -1,
	Case When Cre.TipoABC='B' 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * 
			Cre.CotizacionMoneda * -1
		Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda * -1
	End,
	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1,
	Cre.ImporteTotal * Cre.CotizacionMoneda * -1
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 WHERE (Cre.FechaNotaCredito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and 
	Cre.CtaCte='SI' and Cli.Codigo>=@CodigoDesde and Cli.Codigo<=@CodigoHasta


UPDATE #Auxiliar1
SET TotalGravado=0
WHERE TotalGravado IS NULL

UPDATE #Auxiliar1
SET TotalNoGravado=0
WHERE TotalNoGravado IS NULL

UPDATE #Auxiliar1
SET IVA=0
WHERE IVA IS NULL

UPDATE #Auxiliar1
SET Retenciones=0
WHERE Retenciones IS NULL

UPDATE #Auxiliar1
SET TotalGeneral=0
WHERE TotalGeneral IS NULL

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0000111111111133'
SET @vector_T='0000220545533300'

SELECT 
	0 as [IdComprobante],
	IdCliente as [IdCliente],
	Codigo as [K_Codigo],
	0 as [K_Orden],
	Codigo as [Codigo],
	Cliente as [Cliente],
	CondicionIVA as [Condicion IVA],
	Cuit as [Cuit],
	Null as [Fecha],
	Null as [Comprobante],
	Null as [Total s/impuestos],
	Null as [IVA],
	Null as [Otras ret.],
	Null as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdCliente,Codigo,Cliente,CondicionIVA,Cuit

UNION ALL 

SELECT 
	IdComprobante as [IdComprobante],
	IdCliente as [IdCliente],
	Codigo as [K_Codigo],
	1 as [K_Orden],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Condicion IVA],
	Null as [Cuit],
	Fecha as [Fecha],
	Comprobante as [Comprobante],
	TotalGravado+TotalNoGravado as [Total s/impuestos],
	IVA as [IVA],
	Retenciones as [Otras ret.],
	TotalGeneral as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

UNION ALL 

SELECT 
	0 as [IdComprobante],
	IdCliente as [IdCliente],
	Codigo as [K_Codigo],
	2 as [K_Orden],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Condicion IVA],
	Null as [Cuit],
	Null as [Fecha],
	'TOTALES CLIENTE' as [Comprobante],
	SUM(IsNull(TotalGravado,0)+IsNull(TotalNoGravado,0)) as [Total s/impuestos],
	SUM(IsNull(IVA,0)) as [IVA],
	SUM(IsNull(Retenciones,0)) as [Otras ret.],
	SUM(IsNull(TotalGeneral,0)) as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdCliente,Codigo

UNION ALL 

SELECT 
	0 as [IdComprobante],
	IdCliente as [IdCliente],
	Codigo as [K_Codigo],
	3 as [K_Orden],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Condicion IVA],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Comprobante],
	Null as [Total s/impuestos],
	Null as [IVA],
	Null as [Otras ret.],
	Null as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdCliente,Codigo

UNION ALL 

SELECT 
	0 as [IdComprobante],
	0 as [IdCliente],
	'zzzzzzzzzz' as [K_Codigo],
	4 as [K_Orden],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Condicion IVA],
	Null as [Cuit],
	Null as [Fecha],
	'TOTALES GENERALES' as [Comprobante],
	SUM(IsNull(TotalGravado,0)+IsNull(TotalNoGravado,0)) as [Total s/impuestos],
	SUM(IsNull(IVA,0)) as [IVA],
	SUM(IsNull(Retenciones,0)) as [Otras ret.],
	SUM(IsNull(TotalGeneral,0)) as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Codigo],[K_Orden]

DROP TABLE #Auxiliar1
