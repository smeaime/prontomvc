CREATE Procedure [dbo].[Proveedores_TX_Comprobantes]

@FechaDesde datetime,
@FechaHasta datetime,
@Formato int = Null

AS 

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,0)

CREATE TABLE #Auxiliar2 
			(
			 IdComprobanteProveedor INTEGER,
			 IdCuenta INTEGER,
			 IdObra INTEGER,
			 SumaPorcentajeIva NUMERIC(6,2),
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuenta,
  DetCP.IdObra,
  IsNull(DetCP.IvaComprasPorcentaje1,0)+IsNull(DetCP.IvaComprasPorcentaje2,0)+
	  IsNull(DetCP.IvaComprasPorcentaje3,0)+IsNull(DetCP.IvaComprasPorcentaje4,0)+
	  IsNull(DetCP.IvaComprasPorcentaje5,0)+IsNull(DetCP.IvaComprasPorcentaje6,0)+
	  IsNull(DetCP.IvaComprasPorcentaje7,0)+IsNull(DetCP.IvaComprasPorcentaje8,0)+
	  IsNull(DetCP.IvaComprasPorcentaje9,0)+IsNull(DetCP.IvaComprasPorcentaje10,0),
  DetCP.Importe*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras1,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA1*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA1<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras2,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA2*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA2<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras3,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA3*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA3<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras4,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA4*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA4<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras5,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA5*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA5<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras6,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA6*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA6<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras7,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA7*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA7<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras8,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA8*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA8<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras9,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA9*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA9<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  DetCP.IdComprobanteProveedor,
  DetCP.IdCuentaIvaCompras10,
  DetCP.IdObra,
  0,
  DetCP.ImporteIVA10*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and DetCP.ImporteIVA10<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT  
  cp.IdComprobanteProveedor,
  Parametros.IdCuentaIvaCompras1,
  cp.IdObra,
  0,
  cp.AjusteIVA*cp.CotizacionMoneda
 FROM ComprobantesProveedores cp 
 LEFT OUTER JOIN Parametros ON Parametros.IdParametro=1
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and cp.AjusteIVA<>0 and (cp.Confirmado is null or cp.Confirmado<>'NO')

UPDATE #Auxiliar2
SET IdObra=0
WHERE IdObra IS NULL

CREATE TABLE #Auxiliar3 
			(
			 IdComprobanteProveedor INTEGER,
			 IdCuenta INTEGER,
			 IdObra INTEGER,
			 Importe NUMERIC(18,2),
			)
INSERT INTO #Auxiliar3 
 SELECT  
  #Auxiliar2.IdComprobanteProveedor,
  #Auxiliar2.IdCuenta,
  #Auxiliar2.IdObra,
  SUM(#Auxiliar2.Importe)
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdComprobanteProveedor, #Auxiliar2.IdCuenta, #Auxiliar2.IdObra--,#Auxiliar2.SumaPorcentajeIva


CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProveedor INTEGER,
			 K_Registro INTEGER,
			 CodigoComprobante VARCHAR(10),
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
			 TotalGeneral NUMERIC(18,2),
			 Cuenta VARCHAR(60),
			 Obra VARCHAR(13),
			 Debe NUMERIC(18,2),
			 Haber NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  cp.IdComprobanteProveedor,
  cp.IdProveedor,
  1,
  TiposComprobante.DescripcionAb,
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial,
  DescripcionIva.Descripcion,
  Proveedores.Cuit,
  cp.FechaRecepcion,
  cp.FechaComprobante,
  TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
  cp.NumeroReferencia,
  (cp.TotalBruto-Case When TotalBonificacion is not null Then TotalBonificacion Else 0 End)*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
  (cp.TotalIva1+cp.TotalIva2)*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
  cp.TotalComprobante*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
  Null,
  Null,
  0,
  0
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and cp.IdProveedor is not null 

 UNION ALL 

 SELECT  
  #Auxiliar3.IdComprobanteProveedor,
  cp.IdProveedor,
  2,
  TiposComprobante.DescripcionAb,
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial,
  DescripcionIva.Descripcion,
  Proveedores.Cuit,
  cp.FechaRecepcion,
  cp.FechaComprobante,
  TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
  cp.NumeroReferencia,
  Null,
  Null,
  Null,
  Convert(varchar,Cuentas.Codigo)+'  '+Cuentas.Descripcion,
  Obras.NumeroObra,
  Case When TiposComprobante.Coeficiente=1 Then #Auxiliar3.Importe Else 0 End,
  Case When TiposComprobante.Coeficiente=-1 Then #Auxiliar3.Importe Else 0 End
 FROM #Auxiliar3 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar3.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar3.IdCuenta
 LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar3.IdObra
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 

 UNION ALL 

 SELECT  
  #Auxiliar3.IdComprobanteProveedor,
  cp.IdProveedor,
  2,
  TiposComprobante.DescripcionAb,
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial,
  DescripcionIva.Descripcion,
  Proveedores.Cuit,
  cp.FechaRecepcion,
  cp.FechaComprobante,
  TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
  cp.NumeroReferencia,
  Null,
  Null,
  Null,
  Convert(varchar,Cuentas.Codigo)+'  '+Cuentas.Descripcion,
  Null,
  Case When TiposComprobante.Coeficiente=1 Then 0 Else Sum(#Auxiliar3.Importe) End,
  Case When TiposComprobante.Coeficiente=1 Then Sum(#Auxiliar3.Importe) Else 0 End
 FROM #Auxiliar3 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar3.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Proveedores.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
 GROUP BY #Auxiliar3.IdComprobanteProveedor, cp.IdProveedor, TiposComprobante.DescripcionAb, Proveedores.CodigoEmpresa, Proveedores.RazonSocial, DescripcionIva.Descripcion,
	Proveedores.Cuit, cp.FechaRecepcion, cp.FechaComprobante, TiposComprobante.DescripcionAb, cp.Letra, cp.NumeroComprobante1, cp.NumeroComprobante2, cp.NumeroReferencia,
	TiposComprobante.Coeficiente, Cuentas.Codigo, Cuentas.Descripcion

/*
 SELECT  
  Subdiarios.IdComprobante,
  cp.IdProveedor,
  2,
  TiposComprobante.DescripcionAb,
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
  Null,
  Null,
  Null,
  Convert(varchar,Cuentas.Codigo)+'  '+Cuentas.Descripcion,
  Null,
  Case When TiposComprobante.Coeficiente=1 
	Then Null 
	Else IsNull(Subdiarios.Debe,0)
  End,
  Case When TiposComprobante.Coeficiente=1 
  	Then IsNull(Subdiarios.Haber,0)
	Else Null
  End
  FROM Subdiarios 
  LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Subdiarios.IdCuenta
  LEFT OUTER JOIN ComprobantesProveedores cp ON Subdiarios.IdTipoComprobante=cp.IdTipoComprobante and 
						Subdiarios.IdComprobante=cp.IdComprobanteProveedor
  LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
  LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
  LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
  WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and cp.IdProveedor is not null and 
	((TiposComprobante.Coeficiente=1 and Subdiarios.Haber is not null and Subdiarios.Haber<>0) or 
	 (TiposComprobante.Coeficiente=-1 and Subdiarios.Debe is not null and Subdiarios.Debe<>0))
*/
SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00001111111666116633'
SET @vector_T='00003344115533463300'

IF @Formato=0
    BEGIN
	SELECT 
		IdComprobanteProveedor as [IdComprobanteProveedor],
		Fecha as [K_Fecha],
		Comprobante as [K_Comprobante],
		1 as [K_Orden],
		Comprobante as [Comprobante],
		NumeroReferencia as [Nro.Interno],
		Fecha as [Fecha],
		FechaComprobante as [Fec.Comp.],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		Cuit,
		TotalSinImpuestos as [Total s/impuestos],
		IVA as [IVA],
		TotalGeneral as [Total general],
		CondicionIVA as [Cuenta],
		Null as [Obra],
		Null as [Debe],
		Null as [Haber],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	WHERE K_Registro=1
	
	UNION ALL 
	
	SELECT 
		IdComprobanteProveedor as [IdComprobanteProveedor],
		Fecha as [K_Fecha],
		Comprobante as [K_Comprobante],
		2 as [K_Orden],
		Comprobante as [Comprobante],
		NumeroReferencia as [Nro.Interno],
		Fecha as [Fecha],
		FechaComprobante as [Fec.Comp.],
		CodigoProveedor as [Codigo],
		Null as [Proveedor],
		Cuit,
		Null as [Total s/impuestos],
		Null as [IVA],
		Null as [Total general],	Cuenta as [Cuenta],
		Obra as [Obra],
		Case When Debe<>0 Then Debe Else Null End as [Debe],
		Case When Haber<>0 Then Haber Else Null End as [Haber],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	WHERE K_Registro=2
	
	UNION ALL 
	
	SELECT 
		IdComprobanteProveedor as [IdComprobanteProveedor],
		Fecha as [K_Fecha],
		Comprobante as [K_Comprobante],
		3 as [K_Orden],
		Comprobante as [Comprobante],
		NumeroReferencia as [Nro.Interno],
		Fecha as [Fecha],
		FechaComprobante as [Fec.Comp.],
		Null as [Codigo],
		Null as [Proveedor],
		Null as [Cuit],
		Null as [Total s/impuestos],
		Null as [IVA],
		Null as [Total general],
		SPACE(30)+'TOTALES' as [Cuenta],
		Null as [Obra],
		SUM(Debe) as [Debe],
		SUM(Haber) as [Haber],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdComprobanteProveedor, Fecha, Comprobante, FechaComprobante, NumeroReferencia
	
	UNION ALL 
	
	SELECT 
		IdComprobanteProveedor as [IdComprobanteProveedor],
		Fecha as [K_Fecha],
		Comprobante as [K_Comprobante],
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
		Null as [Cuenta],
		Null as [Obra],
		Null as [Debe],
		Null as [Haber],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdComprobanteProveedor,Fecha,Comprobante
	
	ORDER BY [K_Fecha],[K_Comprobante],[IdComprobanteProveedor],[K_Orden]
    END

IF @Formato=1
    BEGIN
	SELECT 
		IdComprobanteProveedor as [IdComprobanteProveedor],
		Fecha as [K_Fecha],
		Comprobante as [K_Comprobante],
		1 as [K_Orden],
		Comprobante as [Comprobante],
		NumeroReferencia as [Nro.Interno],
		Fecha as [Fecha],
		FechaComprobante as [Fec.Comp.],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		Cuit,
		TotalSinImpuestos as [Total s/impuestos],
		IVA as [IVA],
		TotalGeneral as [Total general],
		' '+CondicionIVA as [Cuenta],
		Null as [Obra],
		Null as [Debe],
		Null as [Haber],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	WHERE K_Registro=1
	
	UNION ALL 
	
	SELECT 
		IdComprobanteProveedor as [IdComprobanteProveedor],
		Fecha as [K_Fecha],
		Comprobante as [K_Comprobante],
		2 as [K_Orden],
		Comprobante as [Comprobante],
		NumeroReferencia as [Nro.Interno],
		Fecha as [Fecha],
		FechaComprobante as [Fec.Comp.],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		Cuit,
		TotalSinImpuestos as [Total s/impuestos],
		IVA as [IVA],
		TotalGeneral as [Total general],
		Cuenta as [Cuenta],
		Obra as [Obra],
		Case When Debe<>0 Then Debe Else Null End as [Debe],
		Case When Haber<>0 Then Haber Else Null End as [Haber],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	WHERE K_Registro=2

	ORDER BY [K_Fecha],[K_Comprobante],[IdComprobanteProveedor],[K_Orden]
    END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3