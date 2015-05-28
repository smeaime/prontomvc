CREATE  Procedure [dbo].[IBCondiciones_M]

@IdIBCondicion int ,
@Descripcion varchar(50),
@ImporteTopeMinimo numeric(18,2),
@Alicuota numeric(8,3),
@FechaVigencia datetime,
@AcumulaMensualmente varchar(2),
@BaseCalculo varchar(15),
@AlicuotaPercepcion numeric(8,3),
@IdProvincia int,
@ImporteTopeMinimoPercepcion numeric(18,2),
@AlicuotaPercepcionConvenio numeric(8,3),
@IdCuentaPercepcionIIBB int,
@IdCuentaPercepcionIIBBConvenio int,
@PorcentajeATomarSobreBase numeric(6,2),
@PorcentajeAdicional numeric(6,2),
@LeyendaPorcentajeAdicional varchar(50),
@Codigo int,
@CodigoAFIP int,
@InformacionAuxiliar varchar(50),
@IdCuentaPercepcionIIBBCompras int,
@IdProvinciaReal int,
@CodigoNormaRetencion int,
@CodigoNormaPercepcion int,
@CodigoActividad int,
@CodigoArticuloInciso varchar(5)

AS

UPDATE IBCondiciones
SET 
 Descripcion=@Descripcion,
 ImporteTopeMinimo=@ImporteTopeMinimo,
 Alicuota=@Alicuota,
 FechaVigencia=@FechaVigencia,
 AcumulaMensualmente=@AcumulaMensualmente,
 BaseCalculo=@BaseCalculo,
 AlicuotaPercepcion=@AlicuotaPercepcion,
 IdProvincia=@IdProvincia,
 ImporteTopeMinimoPercepcion=@ImporteTopeMinimoPercepcion,
 AlicuotaPercepcionConvenio=@AlicuotaPercepcionConvenio,
 IdCuentaPercepcionIIBB=@IdCuentaPercepcionIIBB,
 IdCuentaPercepcionIIBBConvenio=@IdCuentaPercepcionIIBBConvenio,
 PorcentajeATomarSobreBase=@PorcentajeATomarSobreBase,
 PorcentajeAdicional=@PorcentajeAdicional,
 LeyendaPorcentajeAdicional=@LeyendaPorcentajeAdicional,
 Codigo=@Codigo,
 CodigoAFIP=@CodigoAFIP,
 InformacionAuxiliar=@InformacionAuxiliar,
 IdCuentaPercepcionIIBBCompras=@IdCuentaPercepcionIIBBCompras,
 IdProvinciaReal=@IdProvinciaReal,
 CodigoNormaRetencion=@CodigoNormaRetencion,
 CodigoNormaPercepcion=@CodigoNormaPercepcion,
 CodigoActividad=@CodigoActividad,
 CodigoArticuloInciso=@CodigoArticuloInciso
WHERE (IdIBCondicion=@IdIBCondicion)

RETURN(@IdIBCondicion)