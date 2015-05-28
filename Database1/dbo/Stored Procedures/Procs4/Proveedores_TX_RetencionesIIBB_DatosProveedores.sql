CREATE PROCEDURE [dbo].[Proveedores_TX_RetencionesIIBB_DatosProveedores]

@Desde datetime,
@Hasta datetime,
@Formato int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 A_IdDetalleOrdenPagoImpuestos INTEGER,
			 A_IdProveedor INTEGER,
			 A_Proveedor VARCHAR(50),
			 A_DireccionProveedor VARCHAR(50),
			 A_LocalidadProveedor VARCHAR(50),
			 A_ProvinciaProveedor VARCHAR(50),
			 A_CodigoPostal VARCHAR(30),
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
			 A_Registro VARCHAR(300),
			 A_EsConvenio VARCHAR(1),
			 A_CodigoProvincia VARCHAR(2)
			)
INSERT INTO #Auxiliar 
 SELECT 
  DetOP.IdDetalleOrdenPagoImpuestos,
  pr.IdProveedor,
  IsNull(pr.RazonSocial,''),
  IsNull(pr.Direccion,''),
  IsNull(Localidades.Nombre,''),
  IsNull(Provincias.Nombre,''),
  IsNull(pr.CodigoPostal,'0000'),
  pr.Cuit,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  IBCondiciones.Codigo,
  (Select Sum(Case When dop.Importe is not null Then dop.Importe Else 0 End) 
   From DetalleOrdenesPago dop
   Where dop.IdOrdenPago=DetOP.IdOrdenPago and dop.IdIBCondicion is not null and dop.IdIBCondicion=DetOP.IdIBCondicion)*op.CotizacionMoneda*100,
  DetOP.ImportePagado*op.CotizacionMoneda*100,
  Case When DetOP.AlicuotaAplicada is not null Then DetOP.AlicuotaAplicada Else DetOP.AlicuotaConvenioAplicada End*100,
  DetOP.ImpuestoRetenido*op.CotizacionMoneda*100,
  DetOP.NumeroCertificadoRetencionIIBB,
  (Select Top 1 cp.NumeroComprobante2
   From DetalleOrdenesPago dp
   Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
   Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
   Where dp.IdOrdenPago=DetOP.IdOrdenPago and dp.IdIBCondicion=DetOP.IdIBCondicion),
  IBCondiciones.IdProvincia,
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  (Select Top 1 Provincias.TipoRegistro From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI' Then DetOP.IdIBCondicion Else 0 End,
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI' Then IBCondiciones.Descripcion Else '' End,
  (Select Top 1 Empresa.Cuit From Empresa),
  IsNull(pr.IBNumeroInscripcion,''),
  '',
  Case When IsNull(pr.IBCondicion,0)=2 Then 'S' Else 'N' End,
  IsNull(Provincias.Codigo,'00')
 FROM DetalleOrdenesPagoImpuestos DetOP
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=DetOP.IdIBCondicion
 LEFT OUTER JOIN Proveedores pr ON pr.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN Localidades ON pr.IdLocalidad = Localidades.IdLocalidad 
 LEFT OUTER JOIN Provincias ON pr.IdProvincia = Provincias.IdProvincia
 WHERE op.IdProveedor is not null and 
	(op.FechaOrdenPago between @Desde and @Hasta) and 
	(op.Anulada is null or op.Anulada<>'SI') and 
	(op.Confirmado is null or op.Confirmado<>'NO') and 
	DetOP.TipoImpuesto='I.Brutos' and DetOP.ImpuestoRetenido>0 and 
	(op.RetencionIBrutos is not null and op.RetencionIBrutos>0)

INSERT INTO #Auxiliar 
 SELECT 
  op.IdOrdenPago,
  pr.IdProveedor,
  IsNull(pr.RazonSocial,''),
  IsNull(pr.Direccion,''),
  IsNull(Localidades.Nombre,''),
  IsNull(Provincias.Nombre,''),
  IsNull(pr.CodigoPostal,'0000'),
  pr.Cuit,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  IBCondiciones.Codigo,
  Case When IsNull(op.Acreedores,0)<>0 Then op.Acreedores Else IsNull(op.Valores,0) End * op.CotizacionMoneda * 100,
  Case When IsNull(op.Acreedores,0)<>0 Then op.Acreedores Else IsNull(op.Valores,0) End * op.CotizacionMoneda * 100,
  IsNull(IBCondiciones.Alicuota,0) * 100,
  op.RetencionIBrutos * op.CotizacionMoneda * 100,
  op.NumeroCertificadoRetencionIIBB,
  (Select Top 1 cp.NumeroComprobante2
   From DetalleOrdenesPago dp
   Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dp.IdImputacion
   Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=Cta.IdComprobante
   Where dp.IdOrdenPago=op.IdOrdenPago and dp.IdIBCondicion=pr.IBCondicion),
  IBCondiciones.IdProvincia,
  (Select Top 1 Provincias.Nombre From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  (Select Top 1 Provincias.TipoRegistro From Provincias Where Provincias.IdProvincia=IBCondiciones.IdProvincia),
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI' Then pr.IBCondicion Else 0 End,
  Case When IsNull((Select Top 1 Prov.ExportarConApertura From Provincias Prov Where IBCondiciones.IdProvincia = Prov.IdProvincia),'SI')='SI' Then IBCondiciones.Descripcion Else '' End,
  (Select Top 1 Empresa.Cuit From Empresa),
  IsNull(pr.IBNumeroInscripcion,''),
  '',
  Case When IsNull(pr.IBCondicion,0)=2 Then 'S' Else 'N' End,
  IsNull(Provincias.Codigo,'00')
 FROM OrdenesPago op
 LEFT OUTER JOIN Proveedores pr ON pr.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=pr.IBCondicion
 LEFT OUTER JOIN Localidades ON pr.IdLocalidad = Localidades.IdLocalidad 
 LEFT OUTER JOIN Provincias ON pr.IdProvincia = Provincias.IdProvincia
 WHERE op.IdProveedor is not null and 
	(op.FechaOrdenPago between @Desde and @Hasta) and 
	(op.Anulada is null or op.Anulada<>'SI') and 
	(op.Confirmado is null or op.Confirmado<>'NO') and IsNull(op.RetencionIBrutos,0)<>0 and 
	not exists(Select Top 1 DetOP.IdOrdenPago
			From DetalleOrdenesPagoImpuestos DetOP
			Where op.IdOrdenPago=DetOP.IdOrdenPago and DetOP.TipoImpuesto='I.Brutos')

UPDATE #Auxiliar
SET A_ImporteTotal = 0
WHERE A_ImporteTotal IS NULL

UPDATE #Auxiliar
SET A_Alicuota = 0
WHERE A_Alicuota IS NULL

UPDATE #Auxiliar
SET A_BaseCalculo = 0
WHERE A_BaseCalculo IS NULL

UPDATE #Auxiliar
SET A_ImporteRetencion = 0
WHERE A_ImporteRetencion IS NULL

UPDATE #Auxiliar
SET A_NumeroCertificado = 0
WHERE A_NumeroCertificado IS NULL

UPDATE #Auxiliar
SET A_NumeroComprobanteImputado = Convert(numeric(8,0),'9'+Substring('0000000',1,7-len(Convert(varchar,#Auxiliar.A_IdDetalleOrdenPagoImpuestos)))+Convert(varchar,#Auxiliar.A_IdDetalleOrdenPagoImpuestos))
WHERE A_NumeroComprobanteImputado IS NULL

UPDATE #Auxiliar
SET A_TipoRegistro = 0
WHERE A_TipoRegistro IS NULL

UPDATE #Auxiliar
SET A_CodigoCondicion = 0
WHERE A_CodigoCondicion IS NULL

UPDATE #Auxiliar
SET A_CuitProveedor = '00-00000000-0'
WHERE A_CuitProveedor IS NULL

UPDATE #Auxiliar
SET A_IBNumeroInscripcion=REPLACE(A_IBNumeroInscripcion,'-','')

UPDATE #Auxiliar
SET A_IBNumeroInscripcion=REPLACE(A_IBNumeroInscripcion,'.','')

UPDATE #Auxiliar
SET A_CodigoPostal='0000'
WHERE A_CodigoPostal IS NULL

UPDATE #Auxiliar
SET A_CodigoPostal=Substring(A_CodigoPostal,1,8)
WHERE Len(A_CodigoPostal)>8

UPDATE #Auxiliar
SET A_Registro = '80'+
		 Substring(#Auxiliar.A_CuitProveedor,1,2)+Substring(#Auxiliar.A_CuitProveedor,4,8)+Substring(#Auxiliar.A_CuitProveedor,13,1)+
		 Substring(Rtrim(A_Proveedor)+'                                        ' ,1,33)+
		 Substring(Rtrim(A_DireccionProveedor)+'                                                  ' ,1,47)+
		 '     '+
		 Substring(Rtrim(A_LocalidadProveedor)+'               ' ,1,15)+
		 Substring(Rtrim(A_ProvinciaProveedor)+'               ' ,1,15)+
		 Substring('00000000000',1,11-len(Convert(varchar,A_IBNumeroInscripcion)))+Convert(varchar,A_IBNumeroInscripcion)+
		 Substring('        ',1,8-len(Rtrim(A_CodigoPostal)))+Rtrim(A_CodigoPostal)

UPDATE #Auxiliar
SET A_Registro = '80'+
		 Substring(#Auxiliar.A_CuitProveedor,1,2)+Substring(#Auxiliar.A_CuitProveedor,4,8)+Substring(#Auxiliar.A_CuitProveedor,13,1)+
		 Substring(Rtrim(A_Proveedor)+'                                        ' ,1,40)+
		 Substring(Rtrim(A_DireccionProveedor)+'                                        ',1,40)+
		 '     '+
		 Substring(Rtrim(A_LocalidadProveedor)+'               ' ,1,15)+
		 Substring(Rtrim(A_ProvinciaProveedor)+'               ' ,1,15)+
		 Substring('00000000000',1,11-len(Convert(varchar,A_IBNumeroInscripcion)))+Convert(varchar,A_IBNumeroInscripcion)+
		 Substring('        ',1,8-len(Rtrim(A_CodigoPostal)))+Rtrim(A_CodigoPostal)
WHERE A_TipoRegistro=10

UPDATE #Auxiliar
SET A_Registro = Substring(Rtrim(A_Proveedor)+'                                                                      ' ,1,70)+
		 Substring(#Auxiliar.A_CuitProveedor,1,2)+Substring(#Auxiliar.A_CuitProveedor,4,8)+Substring(#Auxiliar.A_CuitProveedor,13,1)+
		 '00'+
		 A_EsConvenio+
		 Substring('0000000000',1,10-len(Convert(varchar,A_IBNumeroInscripcion)))+Convert(varchar,A_IBNumeroInscripcion)+
		 A_CodigoProvincia+
		 Substring(Rtrim(A_LocalidadProveedor)+'                              ',1,30)+
		 '                              '+
		 Substring(Rtrim(A_DireccionProveedor)+'                              ',1,30)+
		 '00000'+
		 '     '+
		 '     '+
		 '     '+
		 Substring('        ',1,8-len(Rtrim(A_CodigoPostal)))+Rtrim(A_CodigoPostal)+
		 '     '
WHERE A_TipoRegistro=11

SET NOCOUNT OFF

SELECT DISTINCT A_Registro
FROM #Auxiliar 

DROP TABLE #Auxiliar