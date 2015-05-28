CREATE Procedure [dbo].[Clientes_TX_RetencionesIVA]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdCuentaRetencionIva int, @IdCuentaRetencionIvaComprobantesM int

SET @IdCuentaRetencionIva=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaRetencionIvaCobros'),0)
IF @IdCuentaRetencionIva=0
	SET @IdCuentaRetencionIva=IsNull((Select IdCuentaRetencionIva From Parametros Where IdParametro=1),0)
SET @IdCuentaRetencionIvaComprobantesM=IsNull((Select IdCuentaRetencionIvaComprobantesM From Parametros Where IdParametro=1),0)

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
			 RetencionIVA NUMERIC(18,2),
			 Registro VARCHAR(70)
			)
INSERT INTO #Auxiliar1 
 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo,
  IsNull(Clientes.RazonSocial,'OTROS'), IsNull(Clientes.Cuit,'00-00000000-0'),
  re.FechaRecibo, re.NumeroRecibo, IsNull(re.NumeroCertificadoRetencionIVA,0),
  re.RetencionIVA * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.RetencionIVA,0)>0

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante1,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros1 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros1,0)<>0 and 
	(IsNull(re.IdCuenta1,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta1,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante2,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros2 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros2,0)<>0 and 
	(IsNull(re.IdCuenta2,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta2,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante3,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros3 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros3,0)<>0 and 
	(IsNull(re.IdCuenta3,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta3,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante4,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros4 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros4,0)<>0 and 
	(IsNull(re.IdCuenta4,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta4,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante5,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros5 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros5,0)<>0 and 
	(IsNull(re.IdCuenta5,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta5,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante6,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros6 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros6,0)<>0 and 
	(IsNull(re.IdCuenta6,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta6,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante7,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros7 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros7,0)<>0 and 
	(IsNull(re.IdCuenta7,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta7,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante8,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros8 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros8,0)<>0 and 
	(IsNull(re.IdCuenta8,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta8,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante9,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros9 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros9,0)<>0 and 
	(IsNull(re.IdCuenta9,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta9,0)=@IdCuentaRetencionIvaComprobantesM)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, IsNull(Clientes.RazonSocial,'OTROS'), 
  IsNull(Clientes.Cuit,'00-00000000-0'), re.FechaRecibo, re.NumeroRecibo, 
  IsNull(re.NumeroComprobante10,IsNull(re.NumeroCertificadoRetencionIVA,0)),
  re.Otros10 * re.CotizacionMoneda, 
  ''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	IsNull(re.Anulado,'NO')<>'SI' and IsNull(re.Otros10,0)<>0 and 
	(IsNull(re.IdCuenta10,0)=@IdCuentaRetencionIva or IsNull(re.IdCuenta10,0)=@IdCuentaRetencionIvaComprobantesM)

UPDATE #Auxiliar1
SET Registro = 	'242'+Cuit+
		Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+'/'+
		Convert(varchar,Year(Fecha))+
		Substring('0000000000000000',1,16-Len(Convert(varchar,NumeroCertificado)))+Convert(varchar,NumeroCertificado)+
		Substring('0000000000000000',1,16-len(Convert(varchar,RetencionIVA)))+Convert(varchar,RetencionIVA)

SET NOCOUNT OFF

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='0001111111133'
set @vector_T='0001554244900'

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
GROUP BY IdCliente,CodigoCliente,Cliente,Cuit

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
	RetencionIVA as [Imp. retenido],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

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
	SUM(RetencionIVA) as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdCliente,CodigoCliente

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
GROUP BY IdCliente,CodigoCliente

UNION ALL 

SELECT 
	0 as [IdCliente],
	'zzzz' as [K_Codigo],
	5 as [K_Orden],
	Null as [Codigo],
	'TOTAL GENERAL' as [Cliente],
	Null as [Cuit],
	Null as [Fecha],
	Null as [Recibo],
	Null as [Certificado],
	SUM(RetencionIVA) as [Imp. retenido],
	Null as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Codigo],[IdCliente],[K_Orden],[Fecha]

DROP TABLE #Auxiliar1