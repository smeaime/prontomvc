CREATE Procedure [dbo].[Clientes_TX_RetencionesGanancias]

@FechaDesde datetime,
@FechaHasta datetime,
@Orden varchar(1) = Null

AS 

SET NOCOUNT ON

SET @Orden=IsNull(@Orden,'C')

DECLARE @IdCuentaRetencionGananciasCobros int
SET @IdCuentaRetencionGananciasCobros=(Select IdCuentaRetencionGananciasCobros From Parametros Where Parametros.IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdComprobante INTEGER,
			 IdEntidad INTEGER,
			 K_Registro INTEGER,
			 CodigoEntidad VARCHAR(10),
			 Entidad VARCHAR(100),
			 Cuit VARCHAR(13),
			 Fecha DATETIME,
			 TipoRetencion VARCHAR(50),
			 CodigoRegimenAFIP INTEGER,
			 Comprobante INTEGER,
			 NumeroCertificado NUMERIC(18,0),
			 RetencionGanancias NUMERIC(18,2),
			 RetencionGananciasParaRegistro NUMERIC(18,0),
			 Registro VARCHAR(60),
			 Registro1 VARCHAR(60)
			)
INSERT INTO #Auxiliar1 
 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroCertificadoRetencionGanancias,0),
  re.RetencionGanancias * re.CotizacionMoneda,
  re.RetencionGanancias * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	(re.RetencionGanancias is not null and re.RetencionGanancias>0)

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante1,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros1 * re.CotizacionMoneda,
  re.Otros1 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros1,0)<>0 and IsNull(re.IdCuenta1,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante2,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros2 * re.CotizacionMoneda,
  re.Otros2 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros2,0)<>0 and IsNull(re.IdCuenta2,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante3,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros3 * re.CotizacionMoneda,
  re.Otros3 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros3,0)<>0 and IsNull(re.IdCuenta3,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante4,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros4 * re.CotizacionMoneda,
  re.Otros4 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros4,0)<>0 and IsNull(re.IdCuenta4,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante5,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros5 * re.CotizacionMoneda,
  re.Otros5 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros5,0)<>0 and IsNull(re.IdCuenta5,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante6,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros6 * re.CotizacionMoneda,
  re.Otros6 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros6,0)<>0 and IsNull(re.IdCuenta6,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante7,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros7 * re.CotizacionMoneda,
  re.Otros7 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros7,0)<>0 and IsNull(re.IdCuenta7,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante8,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros8 * re.CotizacionMoneda,
  re.Otros8 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros8,0)<>0 and IsNull(re.IdCuenta8,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante9,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros9 * re.CotizacionMoneda,
  re.Otros9 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros9,0)<>0 and IsNull(re.IdCuenta9,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT re.IdRecibo, re.IdCliente, 1, Clientes.Codigo, Clientes.RazonSocial,  Clientes.Cuit,
  re.FechaRecibo, TiposRetencionGanancia.Descripcion,
  IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), re.NumeroRecibo,
  IsNull(re.NumeroComprobante10,IsNull(re.NumeroCertificadoRetencionGanancias,0)),
  re.Otros10 * re.CotizacionMoneda,
  re.Otros10 * re.CotizacionMoneda * 100,
  '',''
 FROM Recibos re
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=re.IdCliente
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=re.IdTipoRetencionGanancia
 WHERE re.FechaRecibo between @FechaDesde and @FechaHasta and 
	re.IdCliente is not null and IsNull(re.Anulado,'NO')<>'SI' and 
	IsNull(re.Otros10,0)<>0 and IsNull(re.IdCuenta10,0)=@IdCuentaRetencionGananciasCobros

 UNION ALL

 SELECT DetCom.IdComprobanteProveedor, cp.IdProveedor, 1, Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial, Proveedores.Cuit, cp.FechaComprobante,
  TiposRetencionGanancia.Descripcion, IsNull(TiposRetencionGanancia.CodigoRegimenAFIP,78), 
  cp.NumeroReferencia, cp.NumeroComprobante2,
  DetCom.Importe * tc.Coeficiente * cp.CotizacionMoneda,
  DetCom.Importe * tc.Coeficiente * cp.CotizacionMoneda * 100,
  '',''
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCom.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=cp.IdTipoRetencionGanancia
 WHERE cp.FechaComprobante between @FechaDesde and @FechaHasta and 
	DetCom.IdCuenta is not null and DetCom.IdCuenta=@IdCuentaRetencionGananciasCobros and 
	(DetCom.Importe is not null and DetCom.Importe>0)

 UNION ALL

 SELECT pf.IdPlazoFijo, pf.IdBanco, 1, Bancos.CodigoUniversal, Bancos.Nombre,  Bancos.Cuit,
  pf.FechaVencimiento, '', 78, pf.NumeroCertificado1, pf.NumeroCertificado1, 
  pf.RetencionGanancia * IsNull(pf.CotizacionMonedaAlFinal,1),
  pf.RetencionGanancia * IsNull(pf.CotizacionMonedaAlFinal,1) * 100,
  '',''
 FROM PlazosFijos pf
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=pf.IdBanco
 WHERE pf.FechaVencimiento between @FechaDesde and @FechaHasta and 
	IsNull(pf.Anulado,'NO')<>'SI' and IsNull(pf.RetencionGanancia,0)<>0

UPDATE #Auxiliar1
SET Registro = 	Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1)+
		Substring('0000000000',1,10-len(Substring(Convert(varchar,NumeroCertificado),1,10)))+Substring(Convert(varchar,NumeroCertificado),1,10)+
		Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+
			Convert(varchar,Year(Fecha))+
		Substring('000',1,3-len(Convert(varchar,CodigoRegimenAFIP)))+Convert(varchar,CodigoRegimenAFIP)+
		 Substring(Substring('0000000000000',1,13-len(Convert(varchar,RetencionGananciasParaRegistro)))+Convert(varchar,RetencionGananciasParaRegistro),1,11)+'.'+
		 	Substring(Substring('0000000000000',1,13-len(Convert(varchar,RetencionGananciasParaRegistro)))+Convert(varchar,RetencionGananciasParaRegistro),12,2)


UPDATE #Auxiliar1
SET Registro1 =	Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1)+
		Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+'/'+
			Convert(varchar,Year(Fecha))+
		Substring('000',1,3-len(Convert(varchar,CodigoRegimenAFIP)))+Convert(varchar,CodigoRegimenAFIP)+
		 Substring(Substring('00000000000000',1,14-len(Convert(varchar,RetencionGananciasParaRegistro)))+Convert(varchar,RetencionGananciasParaRegistro),1,12)+'.'+
		 	Substring(Substring('00000000000000',1,14-len(Convert(varchar,RetencionGananciasParaRegistro)))+Convert(varchar,RetencionGananciasParaRegistro),13,2)+
		Substring('000000000000',1,12-len(Substring(Convert(varchar,NumeroCertificado),1,12)))+Substring(Convert(varchar,NumeroCertificado),1,12)

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000111111161133'
SET @vector_T='000115142331100'

IF @Orden='C'
    BEGIN
	SELECT 
		IdEntidad as [IdEntidad],
		CodigoEntidad as [K_Codigo],
		1 as [K_Orden],
		CodigoEntidad as [Codigo],
		Entidad as [Entidad],
		Cuit as [Cuit],
		TipoRetencion as [Tipo ret.],
		Null as [Fecha],
		Null as [Comprob.],
		Null as [Certificado],
		Null as [Imp. retenido],
		Null as [Registro SICORE],
		Null as [Registro Pers. Jur.],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdEntidad,CodigoEntidad,Entidad,Cuit,TipoRetencion
	
	UNION ALL 
	
	SELECT 
		IdEntidad as [IdEntidad],
		CodigoEntidad as [K_Codigo],
		2 as [K_Orden],
		Null as [Codigo],
		Null as [Entidad],
		Null as [Cuit],
		Null as [Tipo ret.],
		Fecha as [Fecha],
		Comprobante as [Comprob.],
		NumeroCertificado as [Certificado],
		RetencionGanancias as [Imp. retenido],
		Registro as [Registro SICORE],
		Registro1 as [Registro Pers. Jur.],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	UNION ALL 
	
	SELECT 
		IdEntidad as [IdEntidad],
		CodigoEntidad as [K_Codigo],
		3 as [K_Orden],
		Null as [Codigo],
		Null as [Entidad],
		Null as [Cuit],
		'TOTAL ENTIDAD' as [Tipo ret.],
		Null as [Fecha],
		Null as [Comprob.],
		Null as [Certificado],
		SUM(RetencionGanancias) as [Imp. retenido],
		Null as [Registro SICORE],
		Null as [Registro Pers. Jur.],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdEntidad,CodigoEntidad
	
	UNION ALL 
	
	SELECT 
		IdEntidad as [IdEntidad],
		CodigoEntidad as [K_Codigo],
		4 as [K_Orden],
		Null as [Codigo],
		Null as [Entidad],
		Null as [Cuit],
		Null as [Tipo ret.],
		Null as [Fecha],
		Null as [Comprob.],
		Null as [Certificado],
		Null as [Imp. retenido],
		Null as [Registro SICORE],
		Null as [Registro Pers. Jur.],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	GROUP BY IdEntidad,CodigoEntidad
	
	UNION ALL 
	
	SELECT 
		0 as [IdEntidad],
		'zzzz' as [K_Codigo],	5 as [K_Orden],
		Null as [Codigo],
		Null as [Entidad],
		Null as [Cuit],
		'TOTAL GENERAL' as [Tipo ret.],
		Null as [Fecha],
		Null as [Comprob.],
		Null as [Certificado],
		SUM(RetencionGanancias) as [Imp. retenido],
		Null as [Registro SICORE],
		Null as [Registro Pers. Jur.],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	
	ORDER BY [K_Codigo],[IdEntidad],[K_Orden],[Fecha]
    END
ELSE
    BEGIN
	SELECT 
		IdEntidad as [IdEntidad],
		CodigoEntidad as [K_Codigo],
		1 as [K_Orden],
		CodigoEntidad as [Codigo],
		Entidad as [Entidad],
		Cuit as [Cuit],
		TipoRetencion as [Tipo ret.],
		Fecha as [Fecha],
		Comprobante as [Comprob.],
		NumeroCertificado as [Certificado],
		RetencionGanancias as [Imp. retenido],
		Registro as [Registro SICORE],
		Registro1 as [Registro Pers. Jur.],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar1
	ORDER BY Fecha, Comprobante, NumeroCertificado
    END

DROP TABLE #Auxiliar1