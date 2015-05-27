CREATE Procedure [dbo].[Proveedores_TX_RetencionesIVA]

@FechaDesde datetime,
@FechaHasta datetime,
@Formato int = Null

AS 

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,0)

DECLARE @CodigoImpuesto varchar(3), @CodigoRegimen varchar(3), @CodigoRegimen1 varchar(3), @CodigoRegimen2 varchar(3), @CodigoOperacion varchar(1), @FechaBoletin varchar(10), 
	@IdCuentaRetencionIva int, @TipoActividadComercializacionGranos int

SET @CodigoImpuesto='767'
SET @CodigoRegimen='212'
SET @CodigoRegimen1='777' -- Para monotributistas
SET @CodigoRegimen2='831' -- Para RG3164 (Empresa de limpieza / seguridad)
SET @CodigoOperacion='1'
SET @FechaBoletin='12/12/2001'

SET @IdCuentaRetencionIva=IsNull((Select IdCuentaRetencionIva From Parametros Where IdParametro=1),0)
SET @TipoActividadComercializacionGranos=IsNull((Select Top 1 TipoActividadComercializacionGranos From Empresa),0)

CREATE TABLE #Auxiliar1 
			(
			 IdOrdenPago INTEGER,
			 IdProveedor INTEGER,
			 K_Registro INTEGER,
			 CodigoAFIP VARCHAR(3),
			 CodigoDGI VARCHAR(2),
			 CodigoProveedor VARCHAR(20),
			 Proveedor VARCHAR(50),
			 Cuit VARCHAR(20),
			 Fecha DATETIME,
			 OrdenPago INTEGER,
			 Letra VARCHAR(1),
			 Comprobante1 INTEGER,
			 Comprobante2 INTEGER,
			 NumeroCertificado INTEGER,
			 Importe NUMERIC(18,2),
			 ImporteRetencionIVA NUMERIC(18,2),
			 IvaPorcentajeExencion NUMERIC(6,2),
			 TipoDocumentoRetenido VARCHAR(2),
			 NumeroDocumentoRetenido VARCHAR(20),
			 CodigoCondicion INTEGER,
			 CodigoRegimen VARCHAR(3),
			 Registro VARCHAR(200)
			)
INSERT INTO #Auxiliar1 
 SELECT  
  op.IdOrdenPago,
  op.IdProveedor,
  1,
  Case When IsNull(cp.Letra,'A')='M' Then '499' Else '241' End,
  IsNull(TiposComprobante.CodigoDgi,'00'),
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial, 
  Proveedores.Cuit,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  op.NumeroCertificadoRetencionIVA,
  IsNull(cp.TotalBruto,0)*IsNull(cp.CotizacionMoneda,1), -- Cta.ImporteTotal,
  dop.ImporteRetencionIVA * op.CotizacionMoneda,
  Case When IsNull(Proveedores.IvaExencionRetencion,'NO')='SI' Then 100 Else IsNull(Proveedores.IvaPorcentajeExencion,0) End,
  '80',
  Case When Proveedores.Cuit is null 
	Then '00000000000000000000'
	Else '000000000'+Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1)
  End,
  IsNull(DescripcionIva.CodigoAFIP,0),
  Case When IsNull(ap.Agrupacion1,0)=1 Then @CodigoRegimen2
	When IsNull(Proveedores.IdCodigoIva,0)=6 Then @CodigoRegimen1 
	When IsNull(Proveedores.IdCodigoIva,0)=1 and IsNull(ImpuestosDirectos.CodigoRegimen,0)>0 Then Convert(varchar,ImpuestosDirectos.CodigoRegimen)
	Else @CodigoRegimen
  End,
  ''
 FROM DetalleOrdenesPago dop
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=dop.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN CuentasCorrientesAcreedores Cta ON Cta.IdCtaCte=dop.IdImputacion
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Cta.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Cta.IdComprobante
 LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN ImpuestosDirectos ON ImpuestosDirectos.IdImpuestoDirecto = cp.IdImpuestoDirecto 
 LEFT OUTER JOIN [Actividades Proveedores] ap ON Proveedores.IdActividad = ap.IdActividad
 WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and 
	op.IdProveedor is not null and IsNull(dop.ImporteRetencionIVA,0)<>0 and IsNull(op.RetencionIVA,0)<>0

 UNION ALL

 SELECT  
  op.IdOrdenPago,
  op.IdProveedor,
  1,
  Case When IsNull(cp.Letra,'A')='M' Then '499' Else '241' End,
  IsNull(TiposComprobante.CodigoDgi,'00'),
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial, 
  Proveedores.Cuit,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  cp.Letra,
  cp.NumeroComprobante1,
  cp.NumeroComprobante2,
  op.NumeroCertificadoRetencionIVA,
  IsNull(cp.TotalBruto,0)*IsNull(cp.CotizacionMoneda,1),
  cp.ImporteRetencionIvaEnOrdenPago * cp.CotizacionMoneda,
  Case When IsNull(Proveedores.IvaExencionRetencion,'NO')='SI' Then 100 Else IsNull(Proveedores.IvaPorcentajeExencion,0) End,
  '80',
  Case When Proveedores.Cuit is null 
	Then '00000000000000000000'
	Else '000000000'+Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1)
  End,
  IsNull(DescripcionIva.CodigoAFIP,0),
  Case When IsNull(ap.Agrupacion1,0)=1 Then @CodigoRegimen2
	When IsNull(Proveedores.IdCodigoIva,0)=6 Then @CodigoRegimen1 
	When IsNull(Proveedores.IdCodigoIva,0)=1 and IsNull(ImpuestosDirectos.CodigoRegimen,0)>0 Then Convert(varchar,ImpuestosDirectos.CodigoRegimen)
	Else @CodigoRegimen
  End,
  ''
 FROM ComprobantesProveedores cp 
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=cp.IdOrdenPagoRetencionIva
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva = Proveedores.IdCodigoIva
 LEFT OUTER JOIN ImpuestosDirectos ON ImpuestosDirectos.IdImpuestoDirecto = cp.IdImpuestoDirecto 
 LEFT OUTER JOIN [Actividades Proveedores] ap ON Proveedores.IdActividad = ap.IdActividad
 WHERE op.IdOrdenPago is not null and op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and op.IdProveedor is not null 

 UNION ALL

 SELECT  
  op.IdOrdenPago,
  op.IdProveedor,
  1,
  '241',
  '01',
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial, 
  Proveedores.Cuit,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  'A',
  0,
  0,
  op.NumeroCertificadoRetencionIVA,
  IsNull(op.Valores,0) * op.CotizacionMoneda,
  IsNull(op.RetencionIVA,0) * op.CotizacionMoneda,
  Case When IsNull(Proveedores.IvaExencionRetencion,'NO')='SI' Then 100 Else IsNull(Proveedores.IvaPorcentajeExencion,0) End,
  '80',
  Case When Proveedores.Cuit is null 
	Then '00000000000000000000'
	Else '000000000'+Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1)
  End,
  IsNull(DescripcionIva.CodigoAFIP,0),
  Case When IsNull(ap.Agrupacion1,0)=1 Then @CodigoRegimen2 When IsNull(Proveedores.IdCodigoIva,0)=6 Then @CodigoRegimen1 Else @CodigoRegimen End,
  ''
 FROM OrdenesPago op
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN [Actividades Proveedores] ap ON Proveedores.IdActividad = ap.IdActividad
 WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and 
	op.IdProveedor is not null and IsNull(op.RetencionIVA,0)<>0 and 
	IsNull((Select Sum(IsNull(dop.ImporteRetencionIVA,0)) From DetalleOrdenesPago dop Where dop.IdOrdenPago=op.IdOrdenPago),0)=0

 UNION ALL

 SELECT  
  0,
  Valores.IdBanco,
  1,
  '241',
  IsNull(TiposComprobante.CodigoDgi,'00'),
  Convert(varchar,Valores.IdBanco),
  Bancos.Nombre, 
  Case When Bancos.Cuit is not null and len(Bancos.Cuit)=13 Then Bancos.Cuit Else '00-00000000-0' End,
  Valores.FechaComprobante,
  Valores.NumeroComprobante,
  'A',
  0,
  0,
  Valores.NumeroComprobante,
  IsNull(Valores.Importe,0) * Valores.CotizacionMoneda,
  IsNull(Valores.Importe,0) * Valores.CotizacionMoneda,
  0,
  '80',
  Case When Bancos.Cuit is not null and len(Bancos.Cuit)=13 
	Then '000000000'+Substring(Bancos.Cuit,1,2)+Substring(Bancos.Cuit,4,8)+Substring(Bancos.Cuit,13,1) 
	Else '00000000000000000000'
  End,
  IsNull(DescripcionIva.CodigoAFIP,0),
  @CodigoRegimen,
  ''
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
 LEFT OUTER JOIN DescripcionIva ON Bancos.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 WHERE Valores.Estado='G' and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.FechaComprobante between @FechaDesde and @FechaHasta) and
	IsNull(Valores.IdCuentaContable,-1)=@IdCuentaRetencionIva

UPDATE #Auxiliar1
SET Registro = 	CodigoDGI+
		Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+'/'+
			Convert(varchar,Year(Fecha))+
		'0000'+
		Substring('0000',1,4-Len(Convert(varchar,Comprobante1)))+Convert(varchar,Comprobante1)+
		Substring('00000000',1,8-Len(Convert(varchar,Comprobante2)))+Convert(varchar,Comprobante2)+
		Substring('0000000000000000',1,16-len(Convert(varchar,Importe)))+Convert(varchar,Importe)+
		@CodigoImpuesto+
		CodigoRegimen+
		@CodigoOperacion+
		Substring('00000000000000',1,14-len(Convert(varchar,Importe)))+Convert(varchar,Importe)+
		Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+'/'+
			Convert(varchar,Year(Fecha))+
		Substring('00',1,2-len(Convert(varchar,CodigoCondicion)))+Convert(varchar,CodigoCondicion)+
		'0'+
		Substring('00000000000000',1,14-len(Convert(varchar,ImporteRetencionIVA)))+Convert(varchar,ImporteRetencionIVA)+
		Substring('000000',1,6-len(Convert(varchar,IvaPorcentajeExencion)))+Convert(varchar,IvaPorcentajeExencion)+
		@FechaBoletin+
		TipoDocumentoRetenido+
		NumeroDocumentoRetenido+
		Substring('00000000000000',1,14-len(Convert(varchar,NumeroCertificado)))+Convert(varchar,NumeroCertificado)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000011111111133'
SET @vector_T='000001434484900'

IF @Formato=0
    BEGIN
	SELECT 
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_Codigo],
		0 as [K_OrdenPago],
		1 as [K_Orden],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		Cuit as [Cuit],
		Null as [Orden pago],
		Null as [Fecha],
		Null as [Certificado],
		Null as [Comprobante],
		Null as [Imp. retenido],
		Null as [Registro],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdProveedor,CodigoProveedor,Proveedor,Cuit
	
	UNION ALL 
	
	SELECT 
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_Codigo],
		OrdenPago as [K_OrdenPago],
		2 as [K_Orden],
		Null as [Codigo],
		Null as [Proveedor],
		Null as [Cuit],
		OrdenPago as [Orden pago],
		Fecha as [Fecha],
		Null as [Certificado],
		Substring(Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,Comprobante1)))+Convert(varchar,Comprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Comprobante2)))+Convert(varchar,Comprobante2),1,15) as [Comprobante],
		ImporteRetencionIVA as [Imp. retenido],
		Registro as [Registro],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	UNION ALL 
	
	SELECT 
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_Codigo],
		9999999999 as [K_OrdenPago],
		3 as [K_Orden],
		Null as [Codigo],
		'TOTAL PROVEEDOR' as [Proveedor],
		Null as [Cuit],
		Null as [Orden pago],
		Null as [Fecha],
		Null as [Certificado],
		Null as [Comprobante],
		SUM(ImporteRetencionIVA) as [Imp. retenido],
		Null as [Registro],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdProveedor,CodigoProveedor
	
	UNION ALL 
	
	SELECT 
		IdProveedor as [IdProveedor],
		CodigoProveedor as [K_Codigo],
		9999999999 as [K_OrdenPago],
		4 as [K_Orden],
		Null as [Codigo],
		Null as [Proveedor],
		Null as [Cuit],
		Null as [Orden pago],
		Null as [Fecha],
		Null as [Certificado],
		Null as [Comprobante],
		Null as [Imp. retenido],
		Null as [Registro],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdProveedor,CodigoProveedor
	
	UNION ALL 
	
	SELECT 
		0 as [IdProveedor],
		'zzzz' as [K_Codigo],
		9999999999 as [K_OrdenPago],
		5 as [K_Orden],
		Null as [Codigo],
		'TOTAL GENERAL' as [Proveedor],
		Null as [Cuit],
		Null as [Orden pago],
		Null as [Fecha],
		Null as [Certificado],
		Null as [Comprobante],
		SUM(ImporteRetencionIVA) as [Imp. retenido],
		Null as [Registro],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	ORDER BY [K_Codigo],[IdProveedor],[K_OrdenPago],[K_Orden]
    END

IF @Formato=1
    BEGIN
	SELECT 
		IdProveedor as [IdProveedor],
		Null as [K_Codigo],
		Null as [K_OrdenPago],
		Null as [K_Orden],
		CodigoProveedor as [Codigo],
		Proveedor as [Proveedor],
		Cuit as [Cuit],
		OrdenPago as [Orden pago],
		Fecha as [Fecha],
		NumeroCertificado as [Certificado],
		Substring(Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,Comprobante1)))+Convert(varchar,Comprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Comprobante2)))+Convert(varchar,Comprobante2),1,15) as [Comprobante],
		ImporteRetencionIVA as [Imp. retenido],
		Registro as [Registro],
		Null as Vector_T,
		Null as Vector_X
	FROM #Auxiliar1
	ORDER BY Proveedor, IdProveedor, Fecha, OrdenPago, [Comprobante]
    END

DROP TABLE #Auxiliar1