CREATE Procedure [dbo].[Proveedores_TX_ResumenCompras]

@FechaDesde datetime,
@FechaHasta datetime,
@CodigoEmpresaDesde varchar(20),
@CodigoEmpresaHasta varchar(20),
@IdProveedor int = Null,
@Formato int = Null

AS 

SET NOCOUNT ON

SET @IdProveedor=IsNull(@IdProveedor,-1)
SET @Formato=IsNull(@Formato,0)

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProveedor INTEGER,
			 CodigoProveedor VARCHAR(20),
			 Proveedor VARCHAR(50),
			 Fecha DATETIME,
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
 Proveedores.CodigoEmpresa,
 Proveedores.RazonSocial,
 cp.FechaRecepcion,
 TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
 cp.NumeroReferencia,
 (cp.TotalBruto-Case When TotalBonificacion is not null Then TotalBonificacion Else 0 End)*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
 (cp.TotalIva1+cp.TotalIva2)*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
 cp.TotalComprobante*cp.CotizacionMoneda*TiposComprobante.Coeficiente
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and 
	cp.IdProveedor is not null and 
	(@IdProveedor=-1 or cp.IdProveedor=@IdProveedor) and 
	Proveedores.CodigoEmpresa>=@CodigoEmpresaDesde and Proveedores.CodigoEmpresa<=@CodigoEmpresaHasta

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00001111111133'
SET @vector_T='00000145353300'

IF @Formato=0
    BEGIN
	SELECT 
		0 as [IdComprobanteProveedor],
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_CodigoProveedor],
		0 as [K_Orden],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		Null as [Fecha],
		Null as [Comprobante],
		Null as [Numero int.],
		Null as [Total s/impuestos],
		Null as [IVA],
		Null as [Total general],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdProveedor,CodigoProveedor,Proveedor
	
	UNION ALL 
	
	SELECT 
		IdComprobanteProveedor as [IdComprobanteProveedor],
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_CodigoProveedor],
		1 as [K_Orden],
		Null as [Codigo],
		Null as [Proveedor],
		Fecha as [Fecha],
		Comprobante as [Comprobante],
		NumeroReferencia as [Numero int.],
		TotalSinImpuestos as [Total s/impuestos],
		IVA as [IVA],
		TotalGeneral as [Total general],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	UNION ALL 
	
	SELECT 
		0 as [IdComprobanteProveedor],
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_CodigoProveedor],
		2 as [K_Orden],
		Null as [Codigo],
		Null as [Proveedor],
		Null as [Fecha],
		'TOTALES PROVEEDOR' as [Comprobante],
		Null as [Numero int.],
		SUM(TotalSinImpuestos) as [Total s/impuestos],
		SUM(IVA) as [IVA],
		SUM(TotalGeneral) as [Total general],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdProveedor,CodigoProveedor
	
	UNION ALL 
	
	SELECT 
		0 as [IdComprobanteProveedor],
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_CodigoProveedor],
		3 as [K_Orden],
		Null as [Codigo],
		Null as [Proveedor],
		Null as [Fecha],
		Null as [Comprobante],
		Null as [Numero int.],
		Null as [Total s/impuestos],
		Null as [IVA],
		Null as [Total general],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdProveedor,CodigoProveedor
	
	UNION ALL 
	
	SELECT 
		0 as [IdComprobanteProveedor],
		0 as [IdProveedor],
		'zzzzzzzzzz' as [K_CodigoProveedor],
		4 as [K_Orden],
		Null as [Codigo],
		Null as [Proveedor],
		Null as [Fecha],
		'TOTALES GENERALES' as [Comprobante],
		Null as [Numero int.],
		SUM(TotalSinImpuestos) as [Total s/impuestos],	
		SUM(IVA) as [IVA],
		SUM(TotalGeneral) as [Total general],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	ORDER BY [K_CodigoProveedor],[K_Orden]
    END

IF @Formato=1
    BEGIN
	SELECT  
		IdComprobanteProveedor as [IdComprobanteProveedor],
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_CodigoProveedor],
		0 as [K_Orden],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		Fecha as [Fecha],
		Comprobante as [Comprobante],
		NumeroReferencia as [Numero int.],
		TotalSinImpuestos as [Total s/impuestos],
		IVA as [IVA],
		TotalGeneral as [Total general],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	ORDER BY CodigoProveedor, Proveedor, Fecha, NumeroReferencia
    END

DROP TABLE #Auxiliar1