
CREATE Procedure [dbo].[Proveedores_TX_Comprobantes_Modelo2]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProveedor INTEGER,
			 CodigoComprobante VARCHAR(10),
			 Letra VARCHAR(1),
			 CodigoProveedor VARCHAR(20),
			 Proveedor VARCHAR(50),
			 CondicionIVA VARCHAR(50),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 FechaComprobante DATETIME,
			 Comprobante VARCHAR(25),
			 NumeroReferencia INTEGER,
			 TotalSinImpuestos NUMERIC(18,2),
			 IVA NUMERIC(18,2),
			 TotalGeneral NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  cp.IdComprobanteProveedor,
  cp.IdProveedor,
  TiposComprobante.DescripcionAb,
  cp.Letra,
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial,
  DescripcionIva.Descripcion,
  Proveedores.Cuit,
  cp.FechaRecepcion,
  cp.FechaComprobante,
  TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2),
  cp.NumeroReferencia,
  (cp.TotalBruto-Case When TotalBonificacion is not null Then TotalBonificacion Else 0 End)*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
  (cp.TotalIva1+cp.TotalIva2)*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
  cp.TotalComprobante*cp.CotizacionMoneda*TiposComprobante.Coeficiente
  FROM ComprobantesProveedores cp
  LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
  LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
  LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
  WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and cp.IdProveedor is not null 

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000000111111166633'
SET @vector_T='000000334411553300'

SELECT 
	IdComprobanteProveedor as [IdComprobanteProveedor],
	CodigoComprobante as [K_CodigoComprobante],
	Letra as [K_Letra],
	Comprobante as [K_Comprobante],
	Fecha as [K_Fecha],
	1 as [K_Orden],
	Comprobante as [Comprobante],
	NumeroReferencia as [Nro.Interno],
	Fecha as [Fecha],
	FechaComprobante as [Fec.Comp.],
	CodigoProveedor as [Codigo],
	Proveedor as [Proveedor],
	Cuit as [Cuit],
	TotalSinImpuestos as [Total s/impuestos],
	IVA as [IVA],
	TotalGeneral as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

UNION ALL

SELECT 
	0 as [IdComprobanteProveedor],
	CodigoComprobante as [K_CodigoComprobante],
	Letra as [K_Letra],
	'zzzzz' as [K_Comprobante],
	Null as [K_Fecha],
	2 as [K_Orden],
	Null as [Comprobante],
	Null as [Nro.Interno],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Codigo],
	'TOTAL LETRA '+CodigoComprobante+' '+Letra as [Proveedor],
	Null as [Cuit],
	Sum(IsNull(TotalSinImpuestos,0)) as [Total s/impuestos],
	Sum(IsNull(IVA,0)) as [IVA],
	Sum(IsNull(TotalGeneral,0)) as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY CodigoComprobante, Letra

UNION ALL

SELECT 
	0 as [IdComprobanteProveedor],
	CodigoComprobante as [K_CodigoComprobante],
	'z' as [K_Letra],
	'zzzzz' as [K_Comprobante],
	Null as [K_Fecha],
	3 as [K_Orden],
	Null as [Comprobante],
	Null as [Nro.Interno],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Codigo],
	'TOTAL TIPO '+CodigoComprobante as [Proveedor],
	Null as [Cuit],
	Sum(IsNull(TotalSinImpuestos,0)) as [Total s/impuestos],
	Sum(IsNull(IVA,0)) as [IVA],
	Sum(IsNull(TotalGeneral,0)) as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY CodigoComprobante

UNION ALL

SELECT 
	0 as [IdComprobanteProveedor],
	'zzzzz' as [K_CodigoComprobante],
	'z' as [K_Letra],
	'zzzzz' as [K_Comprobante],
	Null as [K_Fecha],
	4 as [K_Orden],
	Null as [Comprobante],
	Null as [Nro.Interno],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Codigo],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Total s/impuestos],
	Null as [IVA],
	Null as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

UNION ALL

SELECT 
	0 as [IdComprobanteProveedor],
	'zzzzz' as [K_CodigoComprobante],
	'z' as [K_Letra],
	'zzzzz' as [K_Comprobante],
	Null as [K_Fecha],
	5 as [K_Orden],
	Null as [Comprobante],
	Null as [Nro.Interno],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Codigo],
	'TOTAL GENERAL' as [Proveedor],
	Null as [Cuit],
	Sum(IsNull(TotalSinImpuestos,0)) as [Total s/impuestos],
	Sum(IsNull(IVA,0)) as [IVA],
	Sum(IsNull(TotalGeneral,0)) as [Total general],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_CodigoComprobante], [K_Letra], [K_Comprobante], [K_Orden]

DROP TABLE #Auxiliar1
