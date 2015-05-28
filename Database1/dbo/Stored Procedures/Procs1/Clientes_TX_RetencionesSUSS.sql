CREATE Procedure [dbo].[Clientes_TX_RetencionesSUSS]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdCuentaRetencionSUSS_Recibida int
SET @IdCuentaRetencionSUSS_Recibida=(Select Top 1 Parametros.IdCuentaRetencionSUSS_Recibida From Parametros Where Parametros.IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdRecibo INTEGER,
			 IdCliente INTEGER,
			 K_Registro INTEGER,
			 CodigoCliente VARCHAR(10),
			 Cliente VARCHAR(100),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 Comprobante INTEGER,
			 NumeroCertificado INTEGER,
			 RetencionSUSS1 NUMERIC(18,2),
			 RetencionSUSS2 NUMERIC(18,2),
			 RetencionSUSS3 NUMERIC(18,2),
			 RetencionSUSS4 NUMERIC(18,2),
			 RetencionSUSS5 NUMERIC(18,2),
			 RetencionSUSS6 NUMERIC(18,2),
			 RetencionSUSS7 NUMERIC(18,2),
			 RetencionSUSS8 NUMERIC(18,2),
			 RetencionSUSS9 NUMERIC(18,2),
			 RetencionSUSS10 NUMERIC(18,2),
			 RetencionSUSS NUMERIC(18,2),
			 Registro VARCHAR(70)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  re.IdRecibo,
  re.IdCliente,
  1,
  Clientes.Codigo,
  Clientes.RazonSocial, 
  Clientes.Cuit,
  re.FechaRecibo,
  re.NumeroRecibo,
  Case When IsNull(re.IdCuenta1,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante1,0)
	When IsNull(re.IdCuenta2,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante2,0)
	When IsNull(re.IdCuenta3,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante3,0)
	When IsNull(re.IdCuenta4,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante4,0)
	When IsNull(re.IdCuenta5,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante5,0)
	When IsNull(re.IdCuenta6,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante6,0)
	When IsNull(re.IdCuenta7,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante7,0)
	When IsNull(re.IdCuenta8,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante8,0)
	When IsNull(re.IdCuenta9,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante9,0)
	When IsNull(re.IdCuenta10,0)=@IdCuentaRetencionSUSS_Recibida Then IsNull(re.NumeroComprobante10,0)
	Else 0
  End,
  Case When re.IdCuenta1 is not null and re.IdCuenta1=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros1 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta2 is not null and re.IdCuenta2=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros2 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta3 is not null and re.IdCuenta3=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros3 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta4 is not null and re.IdCuenta4=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros4 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta5 is not null and re.IdCuenta5=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros5 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta6 is not null and re.IdCuenta6=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros6 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta7 is not null and re.IdCuenta7=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros7 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta8 is not null and re.IdCuenta8=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros8 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta9 is not null and re.IdCuenta9=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros9 * re.CotizacionMoneda
	Else 0
  End,
  Case When re.IdCuenta10 is not null and re.IdCuenta10=@IdCuentaRetencionSUSS_Recibida
	Then re.Otros10 * re.CotizacionMoneda
	Else 0
  End,
  0,
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and re.IdCliente is not null 

UPDATE #Auxiliar1
SET RetencionSUSS = RetencionSUSS1+RetencionSUSS2+RetencionSUSS3+RetencionSUSS4+RetencionSUSS5+RetencionSUSS6+RetencionSUSS7+RetencionSUSS8+RetencionSUSS9+RetencionSUSS10
UPDATE #Auxiliar1
SET Registro = 	SubString(Cuit,1,2)+SubString(Cuit,4,8)+SubString(Cuit,13,1)+
		Convert(varchar,Year(Fecha))+'/'+Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+'/'+Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+
		Substring('0000000000000000000000000',1,25-Len(Convert(varchar,NumeroCertificado)))+Convert(varchar,NumeroCertificado)+
		Substring('000000000000000',1,15-len(Convert(varchar,RetencionSUSS)))+Convert(varchar,RetencionSUSS)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0001111111133'
SET @vector_T='0001554244800'

SELECT 
	IdCliente as [IdCliente],
	CodigoCliente as [K_Codigo],
	1 as [K_Orden],
	CodigoCliente as [Codigo],
	Cliente as [Cliente],
	Cuit as [Cuit],
	Null as [Fecha],
	Null as [Recibo],
	Null as [Certificado],
	Null as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionSUSS<>0
GROUP BY IdCliente, CodigoCliente, Cliente,Cuit

UNION ALL 

SELECT 
	IdCliente as [IdCliente],
	CodigoCliente as [K_Codigo],
	2 as [K_Orden],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Cuit],
	Fecha as [Fecha],
	Comprobante as [Recibo],
	NumeroCertificado as [Certificado],
	RetencionSUSS as [Imp. retenido],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionSUSS<>0

UNION ALL 

SELECT 
	IdCliente as [IdCliente],
	CodigoCliente as [K_Codigo],
	3 as [K_Orden],
	Null as [Codigo],
	'TOTAL CLIENTE' as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Recibo],
	Null as [Certificado],
	SUM(RetencionSUSS) as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionSUSS<>0
GROUP BY IdCliente, CodigoCliente

UNION ALL 

SELECT 
	IdCliente as [IdCliente],
	CodigoCliente as [K_Codigo],
	4 as [K_Orden],
	Null as [Codigo],
	Null as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Recibo],
	Null as [Certificado],
	Null as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionSUSS<>0
GROUP BY IdCliente, CodigoCliente

UNION ALL 

SELECT 
	0 as [IdCliente],
	'zzzz' as [K_Codigo],	5 as [K_Orden],
	Null as [Codigo],
	'TOTAL GENERAL' as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Recibo],
	Null as [Certificado],
	SUM(RetencionSUSS) as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
WHERE RetencionSUSS<>0

ORDER BY [K_Codigo], [IdCliente], [K_Orden], [Fecha]

DROP TABLE #Auxiliar1