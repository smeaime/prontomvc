CREATE PROCEDURE [dbo].[Proveedores_TX_RetencionesIIBB]

@Desde datetime,
@Hasta datetime,
@Formato int,
@CodigoActividad int = Null,
@RegistrosResumidos varchar(3) = Null

AS

SET NOCOUNT ON

SET @RegistrosResumidos=IsNull(@RegistrosResumidos,'')

DECLARE @A_IdDetalleOrdenPagoImpuestos int, @A_Origen int, @A_NumeroOrden int, @A_NumeroOrden1 int, @CodigoActividadIIBB int, @proc_name varchar(1000), @Si2 varchar(3)

SET @CodigoActividadIIBB=IsNull((Select Top 1 CodigoActividadIIBB From Empresa Where IdEmpresa=1),0)
SET @CodigoActividad=IsNull(@CodigoActividad,@CodigoActividadIIBB)
SET @Si2='SI2'

CREATE TABLE #Auxiliar100 
			(
			 A_IdDetalleOrdenPagoImpuestos INTEGER,
			 A_Origen INTEGER,
			 A_Proveedor VARCHAR(50),
			 A_DireccionProveedor VARCHAR(50),
			 A_LocalidadProveedor VARCHAR(50),
			 A_ProvinciaProveedor VARCHAR(50),
			 A_CuitProveedor VARCHAR(13),
			 A_Fecha DATETIME,
			 A_Numero INTEGER,
			 A_CodigoCondicion INTEGER,
			 A_ImporteTotal NUMERIC(18,0),
			 A_BaseCalculo NUMERIC(18,0),
			 A_Alicuota NUMERIC(6,0),
			 A_ImporteRetencion NUMERIC(18,0),
			 A_NumeroCertificado INTEGER,
			 A_NumeroComprobanteImputado NUMERIC(8,0),
			 A_IdProvinciaImpuesto INTEGER,
			 A_ProvinciaImpuesto VARCHAR(50),
			 A_TipoRegistro INTEGER,
			 A_IdIBCondicion INTEGER,
			 A_IBCondicion VARCHAR(50),
			 A_CuitEmpresa VARCHAR(13),
			 A_IBNumeroInscripcion VARCHAR(20),
			 A_CodigoIBCondicion INTEGER,
			 A_LetraComprobanteImputado VARCHAR(1),
			 A_JurisdiccionProveedor VARCHAR(3),
			 A_NumeroOrden INTEGER,
			 A_Registro VARCHAR(300),
			 A_Registro1 VARCHAR(300),
			 A_IdCodigoIva INTEGER,
			 A_ImporteIVA NUMERIC(18,0),
			 A_SucursalComprobanteImputado INTEGER,
			 A_CodigoComprobante VARCHAR(2),
			 A_FechaComprobante DATETIME,
			 A_ImporteComprobante NUMERIC(18,0),
			 A_CodigoNorma INTEGER,
			 A_CodigoActividad INTEGER,
			 A_CodigoArticuloInciso VARCHAR(3),
			 A_OtrosConceptos NUMERIC(18,0),
			 A_CodigoCategoriaIIBBAlternativo VARCHAR(1)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar ON #Auxiliar100 (A_IdDetalleOrdenPagoImpuestos) ON [PRIMARY]

CREATE TABLE #Auxiliar101 
			(
			 A_Id INTEGER,
			 A_Cliente VARCHAR(100),
			 A_CuitCliente VARCHAR(13),
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(1),
			 A_LetraComprobante VARCHAR(1),
			 A_PuntoVenta INTEGER,
			 A_Numero INTEGER,
			 A_BaseImponible NUMERIC(18,0),
			 A_ImportePercepcion NUMERIC(18,0),
			 A_NumeroCertificadoPercepcionIIBB INTEGER,
			 A_Alicuota NUMERIC(6,0),
			 A_TipoRegistro INTEGER,
			 A_IdProvinciaImpuesto INTEGER,
			 A_ProvinciaImpuesto VARCHAR(50),
			 A_CuitEmpresa VARCHAR(11),
			 A_IBNumeroInscripcion VARCHAR(20),
			 A_Registro VARCHAR(300),
			 A_Registro1 VARCHAR(300),
			 A_ImporteIVA NUMERIC(18,0),
			 A_ImporteTotal NUMERIC(18,0),
			 A_IBCondicion INTEGER,
			 A_IdCodigoIva INTEGER,
			 A_CodigoIBCondicion INTEGER,
			 A_CodigoComprobante VARCHAR(2),
			 A_CodigoActividad INTEGER,
			 A_NumeroOrden INTEGER,
			 A_CodigoNorma INTEGER,
			 A_Jurisdiccion VARCHAR(3)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar101 ON #Auxiliar101 (A_Id) ON [PRIMARY]

INSERT INTO #Auxiliar100 
 SELECT 
  DetOP.IdDetalleOrdenPagoImpuestos,
  1,
  IsNull(pr.RazonSocial,''),
  IsNull(pr.Direccion,''),
  IsNull(Localidades.Nombre,''),
  IsNull(Provincias.Nombre,''),
  pr.Cuit,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  IBCondiciones.Codigo,
  (Select Sum(IsNull(dop.Importe,0)) 
   From DetalleOrdenesPago dop
   Where dop.IdOrdenPago=DetOP.IdOrdenPago and dop.IdIBCondicion is not null and dop.IdIBCondicion=DetOP.IdIBCondicion) * op.CotizacionMoneda * 100,
  DetOP.ImportePagado * Case When IsNull(DetOP.PorcentajeATomarSobreBase,0)=0 Then 100 Else DetOP.PorcentajeATomarSobreBase End / 100 * op.CotizacionMoneda * 100,
  Case When DetOP.AlicuotaAplicada is not null Then DetOP.AlicuotaAplicada Else DetOP.AlicuotaConvenioAplicada End * 100,
  DetOP.ImpuestoRetenido*op.CotizacionMoneda * 100,
  DetOP.NumeroCertificadoRetencionIIBB,
  IsNull((Select Top 1 cp.NumeroComprobante2
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),op.NumeroOrdenPago),
  IBCondiciones.IdProvincia,
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  (Select Top 1 Provincias.TipoRegistro From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI'
		Then DetOP.IdIBCondicion
		Else 0
  End,
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI'
		Then IBCondiciones.Descripcion
		Else ''
  End,
  (Select Top 1 Empresa.Cuit From Empresa),
  IsNull(pr.IBNumeroInscripcion,''),
  IsNull(pr.IBCondicion,1),
  IsNull((Select Top 1 cp.Letra
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),'A'),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3),
  0,
  '',
  '',
  pr.IdCodigoIva,
  IsNull((Select Sum(IsNull(cp.TotalIva1,0))
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),0)*100,
  IsNull((Select Top 1 cp.NumeroComprobante1
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),1),
  IsNull((Select Top 1 tc.CodigoDgi
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Left Outer Join TiposComprobante tc On tc.IdTipoComprobante=cp.IdTipoComprobante
		  Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),'01'),
  IsNull((Select Top 1 cp.FechaComprobante
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),op.FechaOrdenPago),
  IsNull((Select Top 1 cp.TotalComprobante
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),0)*100,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  IsNull(IBCondiciones.CodigoArticuloInciso,'020'),
  0,
  IsNull(pr.CodigoCategoriaIIBBAlternativo,'')
 FROM DetalleOrdenesPagoImpuestos DetOP
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN Proveedores pr ON pr.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=IsNull(DetOP.IdIBCondicion,pr.IBCondicion)
 LEFT OUTER JOIN Localidades ON pr.IdLocalidad = Localidades.IdLocalidad 
 LEFT OUTER JOIN Provincias ON pr.IdProvincia = Provincias.IdProvincia
 WHERE op.IdProveedor is not null and IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and 
		(op.FechaOrdenPago between @Desde and @Hasta) and 
		DetOP.TipoImpuesto='I.Brutos' and DetOP.ImpuestoRetenido>0 and IsNull(op.RetencionIBrutos,0)>0 and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UPDATE #Auxiliar100
SET A_ImporteIVA=IsNull(A_ImporteTotal,0)-IsNull(A_BaseCalculo,0)-IsNull(A_OtrosConceptos,0)

INSERT INTO #Auxiliar100 
 SELECT 
  op.IdOrdenPago,
  2,
  IsNull(pr.RazonSocial,''),
  IsNull(pr.Direccion,''),
  IsNull(Localidades.Nombre,''),
  IsNull(Provincias.Nombre,''),
  pr.Cuit,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  IBCondiciones.Codigo,
  Case When IsNull(op.Acreedores,0)<>0 Then op.Acreedores Else IsNull(op.Valores,0) End * op.CotizacionMoneda * 100,
  Case When IsNull(op.Acreedores,0)<>0 Then op.Acreedores Else IsNull(op.Valores,0) End * op.CotizacionMoneda * 100,
  IsNull(IBCondiciones.Alicuota,0) * 100,
  op.RetencionIBrutos * op.CotizacionMoneda * 100,
  op.NumeroCertificadoRetencionIIBB,
  IsNull((Select Top 1 cp.NumeroComprobante2
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=op.IdOrdenPago and dp.IdIBCondicion=pr.IBCondicion),0),
  IBCondiciones.IdProvincia,
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  (Select Top 1 Provincias.TipoRegistro From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI'
		Then pr.IBCondicion
		Else 0
  End,
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI'
  		Then IBCondiciones.Descripcion
		Else ''
  End,
  (Select Top 1 Empresa.Cuit From Empresa),
  IsNull(pr.IBNumeroInscripcion,''),
  IsNull(pr.IBCondicion,1),
  IsNull((Select Top 1 cp.Letra
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=op.IdOrdenPago and dp.IdIBCondicion=pr.IBCondicion),'A'),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3),
  0,
  '',
  '',
  pr.IdCodigoIva,
  0,
  IsNull((Select Top 1 cp.NumeroComprobante1
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=op.IdOrdenPago and dp.IdIBCondicion=pr.IBCondicion),0),
  IsNull((Select Top 1 tc.CodigoDgi
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Left Outer Join TiposComprobante tc On tc.IdTipoComprobante=cp.IdTipoComprobante
		  Where dp.IdOrdenPago=op.IdOrdenPago and dp.IdIBCondicion=pr.IBCondicion),'00'),
  IsNull((Select Top 1 cp.FechaComprobante
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=op.IdOrdenPago and dp.IdIBCondicion=pr.IBCondicion),op.FechaOrdenPago),
  IsNull((Select Top 1 cp.TotalComprobante
		  From DetalleOrdenesPago dp
		  Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
		  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
		  Where dp.IdOrdenPago=op.IdOrdenPago and dp.IdIBCondicion=pr.IBCondicion),0)*100,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  IsNull(IBCondiciones.CodigoArticuloInciso,'020'),
  0,
  IsNull(pr.CodigoCategoriaIIBBAlternativo,'')
 FROM OrdenesPago op
 LEFT OUTER JOIN Proveedores pr ON pr.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=pr.IBCondicion
 LEFT OUTER JOIN Localidades ON pr.IdLocalidad = Localidades.IdLocalidad 
 LEFT OUTER JOIN Provincias ON pr.IdProvincia = Provincias.IdProvincia
 WHERE op.IdProveedor is not null and IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and IsNull(op.RetencionIBrutos,0)<>0 and 
		(op.FechaOrdenPago between @Desde and @Hasta) and 
		IsNull((Select Top 1 Sum(IsNull(DetOP.ImpuestoRetenido,0))
				From DetalleOrdenesPagoImpuestos DetOP
				Where op.IdOrdenPago=DetOP.IdOrdenPago and DetOP.TipoImpuesto='I.Brutos'),0)=0 and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UPDATE #Auxiliar100
SET A_ImporteTotal = 0
WHERE A_ImporteTotal IS NULL

UPDATE #Auxiliar100
SET A_Alicuota = 0
WHERE A_Alicuota IS NULL

UPDATE #Auxiliar100
SET A_BaseCalculo = 0
WHERE A_BaseCalculo IS NULL

UPDATE #Auxiliar100
SET A_ImporteRetencion = 0
WHERE A_ImporteRetencion IS NULL

UPDATE #Auxiliar100
SET A_NumeroCertificado = 0
WHERE A_NumeroCertificado IS NULL

UPDATE #Auxiliar100
SET A_NumeroComprobanteImputado = Convert(numeric(8,0),'9'+Substring('0000000',1,7-len(Convert(varchar,#Auxiliar100.A_IdDetalleOrdenPagoImpuestos)))+Convert(varchar,#Auxiliar100.A_IdDetalleOrdenPagoImpuestos))
WHERE A_NumeroComprobanteImputado IS NULL

UPDATE #Auxiliar100
SET A_TipoRegistro = 0
WHERE A_TipoRegistro IS NULL

UPDATE #Auxiliar100
SET A_CodigoCondicion = 0
WHERE A_CodigoCondicion IS NULL

UPDATE #Auxiliar100
SET A_CuitProveedor = '00-00000000-0'
WHERE A_CuitProveedor IS NULL

UPDATE #Auxiliar100
SET A_IBNumeroInscripcion=REPLACE(A_IBNumeroInscripcion,'-','')

UPDATE #Auxiliar100
SET A_IBNumeroInscripcion=REPLACE(A_IBNumeroInscripcion,'.','')

UPDATE #Auxiliar100
SET A_CodigoComprobante=Case When A_LetraComprobanteImputado='B' Then '06' Else '11' End
WHERE A_LetraComprobanteImputado<>'A' and A_CodigoComprobante='01' and A_TipoRegistro<>9 and A_TipoRegistro<>11

UPDATE #Auxiliar100
SET A_CodigoComprobante=Case When A_LetraComprobanteImputado='B' Then '07' Else '12' End
WHERE A_LetraComprobanteImputado<>'A' and A_CodigoComprobante='02' and A_TipoRegistro<>9 and A_TipoRegistro<>11

UPDATE #Auxiliar100
SET A_CodigoComprobante=Case When A_LetraComprobanteImputado='B' Then '08' Else '13' End
WHERE A_LetraComprobanteImputado<>'A' and A_CodigoComprobante='03' and A_TipoRegistro<>9 and A_TipoRegistro<>11

IF @Formato=1
  BEGIN
	/* Registro para Buenos Aires */
	UPDATE #Auxiliar100
	SET A_Registro = 
		#Auxiliar100.A_CuitProveedor+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		'0000'+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroCertificado)))+Convert(varchar,#Auxiliar100.A_NumeroCertificado)+
		Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,7)+'.'+
			Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),8,2)
	WHERE A_TipoRegistro=1
	
	UPDATE #Auxiliar100
	SET A_Registro1 = 
		#Auxiliar100.A_CuitProveedor+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		'0000'+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroCertificado)))+Convert(varchar,#Auxiliar100.A_NumeroCertificado)+
		Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,8)+'.'+
		Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),9,2)+
		'A'
	WHERE A_TipoRegistro=1
	
	/* Registro para Corrientes */
	UPDATE #Auxiliar100
	SET A_Registro = 
		Substring(#Auxiliar100.A_CuitEmpresa,1,2)+Substring(#Auxiliar100.A_CuitEmpresa,4,8)+Substring(#Auxiliar100.A_CuitEmpresa,13,1)+
		'00'+
		Convert(varchar,Year(#Auxiliar100.A_Fecha))+Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+
		'00'+
		'00'+Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		Convert(varchar,Year(#Auxiliar100.A_Fecha))+'00'+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroCertificado)))+Convert(varchar,#Auxiliar100.A_NumeroCertificado)+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,9)+'.'+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),10,2)+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,2)+'.'+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),3,2)+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,9)+'.'+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),10,2)+
		'0'+
		'S'
	WHERE A_TipoRegistro=2
	
	/* Registro para Chaco */
	UPDATE #Auxiliar100
	SET A_Registro = 
		Substring(#Auxiliar100.A_CuitEmpresa,1,2)+Substring(#Auxiliar100.A_CuitEmpresa,4,8)+Substring(#Auxiliar100.A_CuitEmpresa,13,1)+
		'00'+
		Substring('000000',1,6-len(Convert(varchar,#Auxiliar100.A_NumeroCertificado)))+Convert(varchar,#Auxiliar100.A_NumeroCertificado)+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+
		Substring(LTrim(#Auxiliar100.A_Proveedor)+'                              ',1,30)+
		Substring(LTrim(#Auxiliar100.A_DireccionProveedor)+' '+LTrim(#Auxiliar100.A_LocalidadProveedor)+Space(50),1,50)+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion)+
		Substring('00',1,2-len(Convert(varchar,#Auxiliar100.A_CodigoCondicion)))+Convert(varchar,#Auxiliar100.A_CodigoCondicion)+
		Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo)+
		Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota)+
		'000'
	WHERE A_TipoRegistro=3

	/* Registro para Rio Negro */
	UPDATE #Auxiliar100
	SET A_Registro = 
		Substring(#Auxiliar100.A_CuitEmpresa,1,2)+Substring(#Auxiliar100.A_CuitEmpresa,4,8)+Substring(#Auxiliar100.A_CuitEmpresa,13,1)+';'+
		'202007898'+';'+
		Convert(varchar,Year(#Auxiliar100.A_Fecha))+';'+Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+';'+
		'00'+';'+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+';'+
		LTrim(#Auxiliar100.A_Proveedor)+';'+
		Replace(LTrim(A_IBNumeroInscripcion),'-','')+';'+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+';'+
		Convert(varchar,#Auxiliar100.A_BaseCalculo)+';'+
		Convert(varchar,#Auxiliar100.A_Alicuota)+';'+
		Convert(varchar,#Auxiliar100.A_ImporteRetencion)+';'+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)
	WHERE A_TipoRegistro=4

	/* Registro para Mendoza */
	SET @A_NumeroOrden1=0
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdDetalleOrdenPagoImpuestos, A_Origen, A_NumeroOrden FROM #Auxiliar100 WHERE A_TipoRegistro=5 ORDER BY A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_IBCondicion, A_Fecha, A_Proveedor, A_Numero
	OPEN Cur
	FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_NumeroOrden
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @A_NumeroOrden1=@A_NumeroOrden1+1
		UPDATE #Auxiliar100
		SET A_NumeroOrden = @A_NumeroOrden1 
		WHERE A_IdDetalleOrdenPagoImpuestos=@A_IdDetalleOrdenPagoImpuestos and A_Origen=@A_Origen
		FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_NumeroOrden
	  END
	CLOSE Cur
	DEALLOCATE Cur

	UPDATE #Auxiliar100
	SET A_Registro = 
		#Auxiliar100.A_CuitEmpresa+
		Convert(varchar,Year(#Auxiliar100.A_Fecha))+Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+
		#Auxiliar100.A_CuitProveedor+
		Substring(LTrim(#Auxiliar100.A_Proveedor)+'                                        ',1,40)+
		'S'+
		Substring(LTrim(#Auxiliar100.A_DireccionProveedor)+' '+
			LTrim(#Auxiliar100.A_LocalidadProveedor)+' '+
			LTrim(#Auxiliar100.A_ProvinciaProveedor)+'                                                                       ',1,70)+
		Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+
		'FC'+#Auxiliar100.A_LetraComprobanteImputado+
		Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)+
		'PSO'+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,13)+'.'+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),14,2)+
		Substring(Substring('000000',1,6-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,4)+'.'+
		Substring(Substring('000000',1,6-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),5,2)+'0'+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,13)+'.'+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),14,2)+
		'N'+
		Substring(LTrim(#Auxiliar100.A_JurisdiccionProveedor)+'   ',1,3)+
		Substring('000000',1,6-len(Convert(varchar,#Auxiliar100.A_NumeroOrden)))+Convert(varchar,#Auxiliar100.A_NumeroOrden)
	WHERE A_TipoRegistro=5

	/* Registro para Salta */
	UPDATE #Auxiliar100
	SET A_Registro = 
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+
		Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_NumeroCertificado)))+Convert(varchar,#Auxiliar100.A_NumeroCertificado)+
		Substring(LTrim(#Auxiliar100.A_Proveedor)+'                                                            ',1,60)+
		Substring(LTrim(#Auxiliar100.A_DireccionProveedor)+' '+
			LTrim(#Auxiliar100.A_LocalidadProveedor)+' '+
			LTrim(#Auxiliar100.A_ProvinciaProveedor)+'                                                            ',1,60)+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,13)+'.'+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),14,2)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,13)+'.'+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),14,2)
	WHERE A_TipoRegistro=6

	/* Registro para Capital Federal */
	UPDATE #Auxiliar100
	SET A_Registro = 
		'1'+
		Substring('000',1,3-len(Convert(varchar,#Auxiliar100.A_CodigoNorma)))+Convert(varchar,#Auxiliar100.A_CodigoNorma)+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		'03'+
		' '+
		'00000000'+Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_Numero)))+Convert(varchar,#Auxiliar100.A_Numero)+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteTotal)))+Convert(varchar,#Auxiliar100.A_ImporteTotal),1,9)+','+
			Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteTotal)))+Convert(varchar,#Auxiliar100.A_ImporteTotal),10,2)+
		Substring(Convert(varchar,#Auxiliar100.A_NumeroCertificado)+'                ',1,16)+
		'3'+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+
		Case When Len(IsNull(#Auxiliar100.A_CodigoCategoriaIIBBAlternativo,''))>0 Then #Auxiliar100.A_CodigoCategoriaIIBBAlternativo
				When #Auxiliar100.A_CodigoIBCondicion=1 or #Auxiliar100.A_CodigoIBCondicion=4 Then '4'
				When #Auxiliar100.A_CodigoIBCondicion=2 Then '2'
				Else '1'
		End+
		'0'+Substring('0000000000',1,10-len(Rtrim(LTrim(Substring(Replace(#Auxiliar100.A_IBNumeroInscripcion,'-',''),1,10)))))+
			Rtrim(LTrim(Substring(Replace(#Auxiliar100.A_IBNumeroInscripcion,'-',''),1,10)))+
		Case When #Auxiliar100.A_IdCodigoIva=1 Then '1'
				When #Auxiliar100.A_IdCodigoIva=2 Then '2'
				When #Auxiliar100.A_IdCodigoIva=3 or #Auxiliar100.A_IdCodigoIva=8 or #Auxiliar100.A_IdCodigoIva=9 Then '3'
				When #Auxiliar100.A_IdCodigoIva=4 or #Auxiliar100.A_IdCodigoIva=6 or #Auxiliar100.A_IdCodigoIva=7 or #Auxiliar100.A_IdCodigoIva=10 Then '4'
				Else '0'
		End+
		Substring(#Auxiliar100.A_Proveedor+'                              ',1,30)+
		'0000000000000,00'+
		'000000'+Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar100.A_ImporteIVA)))+Convert(varchar,#Auxiliar100.A_ImporteIVA),1,7)+','+
			Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar100.A_ImporteIVA)))+Convert(varchar,#Auxiliar100.A_ImporteIVA),8,2)+
		'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,9)+','+
			Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),10,2)+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,2)+','+
			Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),3,2)+
		'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,9)+','+
			Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),10,2)+
		'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,9)+','+
			Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),10,2)
	WHERE A_TipoRegistro=7

	/* Registro para Cordoba */
	UPDATE #Auxiliar100
	SET A_Registro = 
		'01'+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_IdDetalleOrdenPagoImpuestos)))+Convert(varchar,#Auxiliar100.A_IdDetalleOrdenPagoImpuestos)+
		'1'+
		Substring('00',1,2-len(Convert(varchar,#Auxiliar100.A_CodigoCondicion)))+Convert(varchar,#Auxiliar100.A_CodigoCondicion)+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		'01'+Substring(Convert(varchar,Year(#Auxiliar100.A_Fecha)),3,2)+
			Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar100.A_NumeroCertificado)))+Convert(varchar,#Auxiliar100.A_NumeroCertificado)+
		#Auxiliar100.A_CuitProveedor+
		Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,10)+','+
			Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),11,2)+
		Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,3)+','+
			Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),4,2)+'00'+
		Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,8)+','+
			Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),9,2)
	WHERE A_TipoRegistro=8

	/* Registro para Santa Fe */
	UPDATE #Auxiliar100
	SET A_Registro = 
		'1'+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		IsNull(#Auxiliar100.A_CodigoArticuloInciso,'020')+
		Case When #Auxiliar100.A_CodigoComprobante='00' Then '03' Else Substring('00',1,2-len(#Auxiliar100.A_CodigoComprobante))+#Auxiliar100.A_CodigoComprobante End+
		#Auxiliar100.A_LetraComprobanteImputado+
			Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_SucursalComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_SucursalComprobanteImputado)+
			Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)+
			'    '+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_FechaComprobante))))+Convert(varchar,Day(#Auxiliar100.A_FechaComprobante))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_FechaComprobante))))+Convert(varchar,Month(#Auxiliar100.A_FechaComprobante))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_FechaComprobante))+
		 Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,11)+','+
 			Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),12,2)+
		'3'+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+
		Case When #Auxiliar100.A_CodigoIBCondicion=1 or #Auxiliar100.A_CodigoIBCondicion=4 Then '3' Else '1' End+
		Substring('0000000000',1,10-len(Rtrim(LTrim(Substring(Replace(#Auxiliar100.A_IBNumeroInscripcion,'-',''),1,10)))))+
			Rtrim(LTrim(Substring(Replace(#Auxiliar100.A_IBNumeroInscripcion,'-',''),1,10)))+
		Case When #Auxiliar100.A_IdCodigoIva=1 Then '1'
				When #Auxiliar100.A_IdCodigoIva=2 Then '2'
				When #Auxiliar100.A_IdCodigoIva=3 or #Auxiliar100.A_IdCodigoIva=8 or #Auxiliar100.A_IdCodigoIva=9 Then '3'
				When #Auxiliar100.A_IdCodigoIva=4 or #Auxiliar100.A_IdCodigoIva=6 or #Auxiliar100.A_IdCodigoIva=7 or #Auxiliar100.A_IdCodigoIva=10 Then '4'
				Else '0'
		End+
		'0'+
		'0'+
		'000000000,00'+
		 Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteIVA)))+Convert(varchar,#Auxiliar100.A_ImporteIVA),1,9)+','+
 			Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_ImporteIVA)))+Convert(varchar,#Auxiliar100.A_ImporteIVA),10,2)+
		 Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,11)+','+
 			Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),12,2)+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,2)+','+
			Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),3,2)+
		 Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,11)+','+
 			Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),12,2)+
		'000000000,00'+
		 Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,11)+','+
 			Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),12,2)+
		 Substring('000',1,3-len(Convert(varchar,#Auxiliar100.A_CodigoCondicion)))+Convert(varchar,#Auxiliar100.A_CodigoCondicion)+
		'0'+
		'0000'+
		'      '+
		Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_NumeroCertificado)))+Convert(varchar,#Auxiliar100.A_NumeroCertificado)
	WHERE A_TipoRegistro=9

	/* Registro para Rio Negro (Diseño 2) */
	SET @A_NumeroOrden1=0
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdDetalleOrdenPagoImpuestos, A_Origen, A_NumeroOrden FROM #Auxiliar100 WHERE A_TipoRegistro=11 ORDER BY A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_IBCondicion, A_Fecha, A_Proveedor, A_Numero
	OPEN Cur
	FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_NumeroOrden
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		SET @A_NumeroOrden1=@A_NumeroOrden1+1
		UPDATE #Auxiliar100
		SET A_NumeroOrden = @A_NumeroOrden1 
		WHERE A_IdDetalleOrdenPagoImpuestos=@A_IdDetalleOrdenPagoImpuestos and A_Origen=@A_Origen
		FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_NumeroOrden
	   END
	CLOSE Cur
	DEALLOCATE Cur

	UPDATE #Auxiliar100
	SET A_Registro = 
		Substring('00',1,2-len(Convert(varchar,#Auxiliar100.A_CodigoActividad)))+Convert(varchar,#Auxiliar100.A_CodigoActividad)+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+
		'00'+Substring(Convert(varchar,Year(#Auxiliar100.A_Fecha)),3,2)+
		Substring('000000000',1,9-len(Convert(varchar,#Auxiliar100.A_NumeroOrden)))+Convert(varchar,#Auxiliar100.A_NumeroOrden)+
		Substring('00',1,2-len(A_CodigoComprobante))+A_CodigoComprobante+
		#Auxiliar100.A_LetraComprobanteImputado+
			Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_SucursalComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_SucursalComprobanteImputado)+
			Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+
		Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,12)+','+
			Substring(Substring('00000000000000',1,15-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),13,2)+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,2)+','+
			Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),3,2)+
		Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,12)+','+
			Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),13,2)
	WHERE A_TipoRegistro=11

	/* Registro para La Rioja */
	SET @A_NumeroOrden1=0
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdDetalleOrdenPagoImpuestos, A_Origen, A_NumeroOrden FROM #Auxiliar100 WHERE A_TipoRegistro=12 ORDER BY A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_IBCondicion, A_Fecha, A_Proveedor, A_Numero
	OPEN Cur
	FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_NumeroOrden
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @A_NumeroOrden1=@A_NumeroOrden1+1
		UPDATE #Auxiliar100
		SET A_NumeroOrden = @A_NumeroOrden1 
		WHERE A_IdDetalleOrdenPagoImpuestos=@A_IdDetalleOrdenPagoImpuestos and A_Origen=@A_Origen
		FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_NumeroOrden
	  END
	CLOSE Cur
	DEALLOCATE Cur

	UPDATE #Auxiliar100
	SET A_Registro = 
		Substring('00000',1,5-len(Convert(varchar,#Auxiliar100.A_NumeroOrden)))+Convert(varchar,#Auxiliar100.A_NumeroOrden)+','+
		'1'+','+
		'1'+','+
		Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)+','+
		Substring(#Auxiliar100.A_CuitProveedor,1,2)+Substring(#Auxiliar100.A_CuitProveedor,4,8)+Substring(#Auxiliar100.A_CuitProveedor,13,1)+','+
		Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+'/'+
			Convert(varchar,Year(#Auxiliar100.A_Fecha))+','+
		Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,10)+'.'+
			Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),11,2)+','+
		Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,3)+'.'+
			Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),4,2)+','+
		Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,10)+'.'+
			Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),11,2)+','+
		Substring('000',1,3-len(Convert(varchar,#Auxiliar100.A_CodigoNorma)))+Convert(varchar,#Auxiliar100.A_CodigoNorma)+','+
		Substring(LTrim(#Auxiliar100.A_JurisdiccionProveedor)+'   ',1,3)
	WHERE A_TipoRegistro=12
  END
ELSE
  BEGIN
	/* Registro para Tucuman (A_TipoRegistro=10), ... */
	UPDATE #Auxiliar100
	SET A_Registro = 
			 Convert(varchar,Year(#Auxiliar100.A_Fecha))+
				 Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar100.A_Fecha))))+Convert(varchar,Month(#Auxiliar100.A_Fecha))+
				 Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar100.A_Fecha))))+Convert(varchar,Day(#Auxiliar100.A_Fecha))+
			 '80'+
			 Substring(#Auxiliar100.A_CuitProveedor,1,2)+
				Substring(#Auxiliar100.A_CuitProveedor,4,8)+
				Substring(#Auxiliar100.A_CuitProveedor,13,1)+
			 Case When IsNull(#Auxiliar100.A_LetraComprobanteImputado,' ')='M' Then '99' Else #Auxiliar100.A_CodigoComprobante End+
			 IsNull(#Auxiliar100.A_LetraComprobanteImputado,' ')+
			 Substring('0000',1,4-len(Convert(varchar,#Auxiliar100.A_SucursalComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_SucursalComprobanteImputado)+
			 Substring('00000000',1,8-len(Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)))+Convert(varchar,#Auxiliar100.A_NumeroComprobanteImputado)+
			 Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),1,12)+'.'+
			 	Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar100.A_BaseCalculo)))+Convert(varchar,#Auxiliar100.A_BaseCalculo),13,2)+
			 Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),1,3)+'.'+
			 	Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar100.A_Alicuota)))+Convert(varchar,#Auxiliar100.A_Alicuota),4,2)+
			 Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),1,12)+'.'+
			 	Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar100.A_ImporteRetencion)))+Convert(varchar,#Auxiliar100.A_ImporteRetencion),13,2)+
			 Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar100.A_IBNumeroInscripcion)))+Convert(varchar,#Auxiliar100.A_IBNumeroInscripcion)+
			'000000000000'
  END

--Arciba, el SI2 es para que no haga un bucle infinito
IF @RegistrosResumidos<>'SI2'
  BEGIN
	SET @proc_name='Clientes_TX_PercepcionesIIBB'
	INSERT INTO #Auxiliar101 
		EXECUTE @proc_name @Desde, @Hasta, @CodigoActividad, @Si2

	DECLARE @A_Id int, @A_Cliente varchar(100), @A_CuitCliente varchar(13), @A_Fecha datetime, @A_TipoComprobante varchar(1), @A_LetraComprobante varchar(1), 
			@A_PuntoVenta int, @A_Numero int, @A_BaseImponible numeric(18,0), @A_ImportePercepcion numeric(18,0), @A_NumeroCertificadoPercepcionIIBB int, 
			@A_Alicuota numeric(6,0), @A_TipoRegistro int, @A_IdProvinciaImpuesto int, @A_ProvinciaImpuesto varchar(50), @A_CuitEmpresa varchar(11), 
			@A_IBNumeroInscripcion varchar(20), @A_Registro varchar(300), @A_Registro1 varchar(300), @A_ImporteIVA numeric(18,0), @A_ImporteTotal numeric(18,0),
			@A_IBCondicion int, @A_IdCodigoIva int, @A_CodigoIBCondicion int, @A_CodigoComprobante varchar(2), @A_CodigoActividad int, @A_CodigoNorma int, 
			@A_Jurisdiccion varchar(3)

	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
			SELECT A_Id, A_Cliente, A_CuitCliente, A_Fecha, A_TipoComprobante, A_LetraComprobante, A_PuntoVenta, A_Numero, A_BaseImponible, A_ImportePercepcion, 
					A_NumeroCertificadoPercepcionIIBB, A_Alicuota, A_TipoRegistro, A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_CuitEmpresa, A_IBNumeroInscripcion,
					A_Registro, A_Registro1, A_ImporteIVA, A_ImporteTotal, A_IBCondicion, A_IdCodigoIva, A_CodigoIBCondicion, A_CodigoComprobante, A_CodigoActividad,
					A_NumeroOrden, A_CodigoNorma, A_Jurisdiccion
			FROM #Auxiliar101
			WHERE A_TipoRegistro=7
			ORDER BY A_Id
	OPEN Cur
	FETCH NEXT FROM Cur INTO @A_Id, @A_Cliente, @A_CuitCliente, @A_Fecha, @A_TipoComprobante, @A_LetraComprobante, @A_PuntoVenta, @A_Numero, @A_BaseImponible, @A_ImportePercepcion, 
							 @A_NumeroCertificadoPercepcionIIBB, @A_Alicuota, @A_TipoRegistro, @A_IdProvinciaImpuesto, @A_ProvinciaImpuesto, @A_CuitEmpresa, @A_IBNumeroInscripcion,
							 @A_Registro, @A_Registro1, @A_ImporteIVA, @A_ImporteTotal, @A_IBCondicion, @A_IdCodigoIva, @A_CodigoIBCondicion, @A_CodigoComprobante, @A_CodigoActividad,
							 @A_NumeroOrden, @A_CodigoNorma, @A_Jurisdiccion
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		INSERT INTO #Auxiliar100
		(A_IdDetalleOrdenPagoImpuestos, A_Origen, A_Proveedor, A_DireccionProveedor, A_LocalidadProveedor, A_ProvinciaProveedor, A_CuitProveedor, A_Fecha,
		 A_Numero, A_CodigoCondicion, A_ImporteTotal, A_BaseCalculo, A_Alicuota, A_ImporteRetencion, A_NumeroCertificado, A_NumeroComprobanteImputado, 
		 A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_TipoRegistro, A_IdIBCondicion, A_IBCondicion, A_CuitEmpresa, A_IBNumeroInscripcion, A_CodigoIBCondicion,
		 A_LetraComprobanteImputado, A_JurisdiccionProveedor, A_NumeroOrden, A_Registro, A_Registro1, A_IdCodigoIva, A_ImporteIVA, A_SucursalComprobanteImputado,
		 A_CodigoComprobante, A_FechaComprobante, A_ImporteComprobante, A_CodigoNorma, A_CodigoActividad, A_CodigoArticuloInciso, A_OtrosConceptos,
		 A_CodigoCategoriaIIBBAlternativo)
		VALUES
		(0, 0, @A_Cliente, '', '', '', @A_CuitCliente, @A_Fecha, @A_Numero, 0, @A_ImporteTotal, @A_BaseImponible, @A_Alicuota, @A_ImportePercepcion, 
		 @A_NumeroCertificadoPercepcionIIBB, 0, @A_IdProvinciaImpuesto, @A_ProvinciaImpuesto, @A_TipoRegistro, 0, @A_IBCondicion, @A_CuitEmpresa, 
		 @A_IBNumeroInscripcion, @A_CodigoIBCondicion, '', @A_Jurisdiccion, @A_NumeroOrden, @A_Registro, @A_Registro1, @A_IdCodigoIva, @A_ImporteIVA, 
		 0, @A_CodigoComprobante, @A_Fecha, 0, @A_CodigoNorma, @A_CodigoActividad, '', 0, '')

		FETCH NEXT FROM Cur INTO @A_Id, @A_Cliente, @A_CuitCliente, @A_Fecha, @A_TipoComprobante, @A_LetraComprobante, @A_PuntoVenta, @A_Numero, @A_BaseImponible, @A_ImportePercepcion, 
								 @A_NumeroCertificadoPercepcionIIBB, @A_Alicuota, @A_TipoRegistro, @A_IdProvinciaImpuesto, @A_ProvinciaImpuesto, @A_CuitEmpresa, @A_IBNumeroInscripcion,
								 @A_Registro, @A_Registro1, @A_ImporteIVA, @A_ImporteTotal, @A_IBCondicion, @A_IdCodigoIva, @A_CodigoIBCondicion, @A_CodigoComprobante, @A_CodigoActividad,
								 @A_NumeroOrden, @A_CodigoNorma, @A_Jurisdiccion
	  END
	CLOSE Cur
	DEALLOCATE Cur
  END

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000111111111111111111111111111133'
SET @vector_T='000555555555555555555555559555500'

IF @RegistrosResumidos=''
  BEGIN
	SELECT 
	 0 as [IdAux1],
	 1 as [K_Tipo],
	 A_IdProvinciaImpuesto as [K_IdProvinciaImpuesto],
	 A_Proveedor as [Entidad],
	 A_DireccionProveedor as [Direccion],
	 A_LocalidadProveedor as [Localidad],
	 A_ProvinciaProveedor as [Provincia],
	 A_CuitProveedor as [Cuit proveedor],
	 A_Fecha as [Fecha Cmp.],
	 A_Numero as [Numero Cmp.],
	 A_ImporteTotal/100 as [Importe total],
	 A_BaseCalculo/100 as [Base Calc.],
	 A_Alicuota/100 as [Alicuota],
	 A_ImporteRetencion/100 as [Importe ret.],
	 A_NumeroCertificado as [Numero certificado],
	 A_CodigoCondicion as [Cod.Cond.],
	 A_NumeroComprobanteImputado as [Numero Doc.],
	 A_ProvinciaImpuesto as [IIBB Provincia],
	 A_CuitEmpresa as [CUIT Empresa],
	 A_TipoRegistro as [Tipo registro],
	 A_IdIBCondicion as [Cod.IIBB],
	 A_IBCondicion as [IIBB],
	 A_Registro as [Registro],
	 A_JurisdiccionProveedor as [Jurisdiccion],
	 A_NumeroOrden as [Nro.Orden],
	 A_Registro1 as [Registro Web],
	 A_IdProvinciaImpuesto as [IdProvinciaImpuesto],
	 A_ImporteTotal/100 as [Imp. total],
	 A_ImporteIVA/100 as [Imp. iva],
	 A_BaseCalculo/100 as [Base Calculo],
	 A_ImporteRetencion/100 as [Imp. ret.],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar100 

	UNION ALL

	SELECT 
	 0 as [IdAux1],
	 2 as [K_Tipo],
	 A_IdProvinciaImpuesto as [K_IdProvinciaImpuesto],
	 'TOTAL PROVINCIA' as [Entidad],
	 Null as [Direccion],
	 Null as [Localidad],
	 Null as [Provincia],
	 Null as [Cuit proveedor],
	 Null as [Fecha Cmp.],
	 Null as [Numero Cmp.],
	 Null as [Importe total],
	 Null as [Base Calc.],
	 Null as [Alicuota],
	 SUM(A_ImporteRetencion/100) as [Importe ret.],
	 Null as [Numero certificado],
	 Null as [Cod.Cond.],
	 Null as [Numero Doc.],
	 Null as [IIBB Provincia],
	 Null as [CUIT Empresa],
	 Null as [Tipo registro],
	 Null as [Cod.IIBB],
	 Null as [IIBB],
	 Null as [Registro],
	 Null as [Jurisdiccion],
	 Null as [Nro.Orden],
	 Null as [Registro Web],
	 Null as [IdProvinciaImpuesto],
	 Null as [Imp. total],
	 Null as [Imp. iva],
	 Null as [Base Calculo],
	 Null as [Imp. ret.],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar100 
	GROUP BY A_IdProvinciaImpuesto

	UNION ALL

	SELECT 
	 0 as [IdAux1],
	 3 as [K_Tipo],
	 A_IdProvinciaImpuesto as [K_IdProvinciaImpuesto],
	 Null as [Entidad],
	 Null as [Direccion],
	 Null as [Localidad],
	 Null as [Provincia],
	 Null as [Cuit proveedor],
	 Null as [Fecha Cmp.],
	 Null as [Numero Cmp.],
	 Null as [Importe total],
	 Null as [Base Calc.],
	 Null as [Alicuota],
	 Null as [Importe ret.],
	 Null as [Numero certificado],
	 Null as [Cod.Cond.],
	 Null as [Numero Doc.],
	 Null as [IIBB Provincia],
	 Null as [CUIT Empresa],
	 Null as [Tipo registro],
	 Null as [Cod.IIBB],
	 Null as [IIBB],
	 Null as [Registro],
	 Null as [Jurisdiccion],
	 Null as [Nro.Orden],
	 Null as [Registro Web],
	 Null as [IdProvinciaImpuesto],
	 Null as [Imp. total],
	 Null as [Imp. iva],
	 Null as [Base Calculo],
	 Null as [Imp. ret.],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar100 
	GROUP BY A_IdProvinciaImpuesto

	UNION ALL

	SELECT 
	 0 as [IdAux1],
	 4 as [K_Tipo],
	 999999 as [K_IdProvinciaImpuesto],
	 'TOTAL GENERAL' as [Entidad],
	 Null as [Direccion],
	 Null as [Localidad],
	 Null as [Provincia],
	 Null as [Cuit proveedor],
	 Null as [Fecha Cmp.],
	 Null as [Numero Cmp.],
	 Null as [Importe total],
	 Null as [Base Calc.],
	 Null as [Alicuota],
	 SUM(A_ImporteRetencion/100) as [Importe ret.],
	 Null as [Numero certificado],
	 Null as [Cod.Cond.],
	 Null as [Numero Doc.],
	 Null as [IIBB Provincia],
	 Null as [CUIT Empresa],
	 Null as [Tipo registro],
	 Null as [Cod.IIBB],
	 Null as [IIBB],
	 Null as [Registro],
	 Null as [Jurisdiccion],
	 Null as [Nro.Orden],
	 Null as [Registro Web],
	 Null as [IdProvinciaImpuesto],
	 Null as [Imp. total],
	 Null as [Imp. iva],
	 Null as [Base Calculo],
	 Null as [Imp. ret.],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar100 

	ORDER By [K_IdProvinciaImpuesto], [K_Tipo], A_ProvinciaImpuesto, [Numero certificado], A_Fecha, [IIBB], A_Proveedor, A_Numero
  END
ELSE
	SELECT *
	FROM #Auxiliar100 
	ORDER By A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_Fecha, A_Proveedor, A_Numero

DROP TABLE #Auxiliar100
DROP TABLE #Auxiliar101
