CREATE Procedure [dbo].[IBCondiciones_A]

@IdIBCondicion int  output,
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

INSERT INTO [IBCondiciones]
(
 Descripcion,
 ImporteTopeMinimo,
 Alicuota,
 FechaVigencia,
 AcumulaMensualmente,
 BaseCalculo,
 AlicuotaPercepcion,
 IdProvincia,
 ImporteTopeMinimoPercepcion,
 AlicuotaPercepcionConvenio,
 IdCuentaPercepcionIIBB,
 IdCuentaPercepcionIIBBConvenio,
 PorcentajeATomarSobreBase,
 PorcentajeAdicional,
 LeyendaPorcentajeAdicional,
 Codigo,
 CodigoAFIP,
 InformacionAuxiliar,
 IdCuentaPercepcionIIBBCompras,
 IdProvinciaReal,
 CodigoNormaRetencion,
 CodigoNormaPercepcion,
 CodigoActividad,
 CodigoArticuloInciso
)
VALUES
(
 @Descripcion,
 @ImporteTopeMinimo,
 @Alicuota,
 @FechaVigencia,
 @AcumulaMensualmente,
 @BaseCalculo,
 @AlicuotaPercepcion,
 @IdProvincia,
 @ImporteTopeMinimoPercepcion,
 @AlicuotaPercepcionConvenio,
 @IdCuentaPercepcionIIBB,
 @IdCuentaPercepcionIIBBConvenio,
 @PorcentajeATomarSobreBase,
 @PorcentajeAdicional,
 @LeyendaPorcentajeAdicional,
 @Codigo,
 @CodigoAFIP,
 @InformacionAuxiliar,
 @IdCuentaPercepcionIIBBCompras,
 @IdProvinciaReal,
 @CodigoNormaRetencion,
 @CodigoNormaPercepcion,
 @CodigoActividad,
 @CodigoArticuloInciso
)

SELECT @IdIBCondicion=@@identity

RETURN(@IdIBCondicion)