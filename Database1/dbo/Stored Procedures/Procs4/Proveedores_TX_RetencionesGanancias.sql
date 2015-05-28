CREATE Procedure [dbo].[Proveedores_TX_RetencionesGanancias]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdOrdenPago INTEGER,
			 IdProveedor INTEGER,
			 K_Registro INTEGER,
			 CodigoProveedor VARCHAR(20),
			 Proveedor VARCHAR(50),
			 Cuit VARCHAR(20),
			 Fecha DATETIME,
			 TipoRetencion VARCHAR(50),
			 Comprobante INTEGER,
			 NumeroCertificado INTEGER,
			 ImportePagado NUMERIC(18,2),
			 RetencionGanancias NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  op.IdOrdenPago,
  op.IdProveedor,
  1,
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial, 
  Proveedores.Cuit,
  op.FechaOrdenPago,
  TiposRetencionGanancia.Descripcion,
  op.NumeroOrdenPago,
  DetOP.NumeroCertificadoRetencionGanancias,
  DetOP.ImportePagado * op.CotizacionMoneda,
  DetOP.ImpuestoRetenido * op.CotizacionMoneda
 FROM DetalleOrdenesPagoImpuestos DetOP
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=DetOP.IdTipoRetencionGanancia
 WHERE op.IdProveedor is not null and 
	(op.FechaOrdenPago between @FechaDesde and @FechaHasta) and 
	IsNull(op.Anulada,'NO')='NO' and 
	IsNull(op.Confirmado,'SI')='SI' and 
	DetOP.TipoImpuesto='Ganancias' and 
	(IsNull(op.RetencionGanancias,0)<>0 or IsNull(DetOP.NumeroCertificadoRetencionGanancias,0)>0)

UNION ALL

 SELECT  
  op.IdOrdenPago,
  op.IdProveedor,
  1,
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial, 
  Proveedores.Cuit,
  op.FechaOrdenPago,
  TiposRetencionGanancia.Descripcion,
  op.NumeroOrdenPago,
  op.NumeroCertificadoRetencionGanancias,
  Case When IsNull(op.Acreedores,0)<>0 
	Then op.Acreedores
	Else IsNull(op.Valores,0)
  End * op.CotizacionMoneda,
  op.RetencionGanancias * op.CotizacionMoneda
 FROM OrdenesPago op
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=Proveedores.IdTipoRetencionGanancia
 WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	IsNull(op.Anulada,'NO')='NO' and 
	IsNull(op.Confirmado,'SI')='SI' and 
	op.IdProveedor is not null and 
	IsNull(op.RetencionGanancias,0)<>0 and 
	IsNull((Select Top 1 Sum(IsNull(DetOP.ImpuestoRetenido,0))
			From DetalleOrdenesPagoImpuestos DetOP
			Where op.IdOrdenPago=DetOP.IdOrdenPago and DetOP.TipoImpuesto='Ganancias'),0)=0

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00011111111133'
SET @vector_T='00001304333300'

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	1 as [K_Orden],
	CodigoProveedor as [Codigo],
	Proveedor as [Proveedor],
	Cuit as [Cuit],
	Null as [Tipo ret.],
	Null as [Fecha],
	Null as [Comprob.],
	Null as [Certificado],
	Null as [Imp. pagado],
	Null as [Imp. retenido],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdProveedor,CodigoProveedor,Proveedor,Cuit

UNION ALL 

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	2 as [K_Orden],
	Null as [Codigo],
	Null as [Proveedor],
	Null as [Cuit],
	TipoRetencion as [Tipo ret.],
	Fecha as [Fecha],
	Comprobante as [Comprob.],
	NumeroCertificado as [Certificado],
	ImportePagado as [Imp. pagado],
	RetencionGanancias as [Imp. retenido],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

UNION ALL 

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	3 as [K_Orden],
	Null as [Codigo],
	Null as [Proveedor],
	Null as [Cuit],
	'TOTAL PROVEEDOR' as [Tipo ret.],
	Null as [Fecha],
	Null as [Comprob.],
	Null as [Certificado],
	SUM(ImportePagado) as [Imp. pagado],
	SUM(RetencionGanancias) as [Imp. retenido],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdProveedor,CodigoProveedor

UNION ALL 

SELECT 
	IdProveedor as [IdProveedor],
	CodigoProveedor as [K_Codigo],
	4 as [K_Orden],
	Null as [Codigo],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Tipo ret.],
	Null as [Fecha],
	Null as [Comprob.],
	Null as [Certificado],
	Null as [Imp. pagado],
	Null as [Imp. retenido],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdProveedor,CodigoProveedor

UNION ALL 

SELECT 
	0 as [IdProveedor],
	'zzzz' as [K_Codigo],
	5 as [K_Orden],
	Null as [Codigo],
	Null as [Proveedor],
	Null as [Cuit],
	'TOTAL GENERAL' as [Tipo ret.],
	Null as [Fecha],
	Null as [Comprob.],
	Null as [Certificado],
	SUM(ImportePagado) as [Imp. pagado],
	SUM(RetencionGanancias) as [Imp. retenido],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Codigo],[IdProveedor],[K_Orden],[Fecha],[Comprob.],[Tipo ret.]

DROP TABLE #Auxiliar1