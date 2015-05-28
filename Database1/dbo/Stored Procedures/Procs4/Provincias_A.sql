CREATE Procedure [dbo].[Provincias_A]

@IdProvincia int  output,
@Nombre varchar(50),
@Codigo varchar(2),
@IdPais int,
@ProximoNumeroCertificadoRetencionIIBB int,
@IdCuentaRetencionIBrutos int,
@TipoRegistro int,
@IdCuentaPercepcionIBrutos int,
@ProximoNumeroCertificadoPercepcionIIBB int,
@TipoRegistroPercepcion int,
@IdCuentaRetencionIBrutosCobranzas int,
@IdCuentaPercepcionIIBBConvenio int,
@ExportarConApertura varchar(2),
@EnviarEmail tinyint,
@InformacionAuxiliar varchar(50),
@IdCuentaPercepcionIIBBCompras int,
@PlantillaRetencionIIBB varchar(50),
@IdCuentaSIRCREB int,
@EsAgenteRetencionIIBB varchar(2),
@IdCuentaPercepcionIIBBComprasJurisdiccionLocal int,
@CodigoESRI varchar(2) ,
@Codigo2 int,
@IdCuentaRetencionIBrutos2 int,
@ProximoNumeroCertificadoRetencionIIBB2 int

AS 

INSERT INTO [Provincias]
(
 Nombre,
 Codigo,
 IdPais,
 ProximoNumeroCertificadoRetencionIIBB,
 IdCuentaRetencionIBrutos,
 TipoRegistro,
 IdCuentaPercepcionIBrutos,
 ProximoNumeroCertificadoPercepcionIIBB,
 TipoRegistroPercepcion,
 IdCuentaRetencionIBrutosCobranzas,
 IdCuentaPercepcionIIBBConvenio,
 ExportarConApertura,
 EnviarEmail,
 InformacionAuxiliar,
 IdCuentaPercepcionIIBBCompras,
 PlantillaRetencionIIBB,
 IdCuentaSIRCREB,
 EsAgenteRetencionIIBB,
 IdCuentaPercepcionIIBBComprasJurisdiccionLocal,
 CodigoESRI,
 Codigo2,
 IdCuentaRetencionIBrutos2,
 ProximoNumeroCertificadoRetencionIIBB2
)
VALUES
(
 @Nombre,
 @Codigo,
 @IdPais,
 @ProximoNumeroCertificadoRetencionIIBB,
 @IdCuentaRetencionIBrutos,
 @TipoRegistro,
 @IdCuentaPercepcionIBrutos,
 @ProximoNumeroCertificadoPercepcionIIBB,
 @TipoRegistroPercepcion,
 @IdCuentaRetencionIBrutosCobranzas,
 @IdCuentaPercepcionIIBBConvenio,
 @ExportarConApertura,
 @EnviarEmail,
 @InformacionAuxiliar,
 @IdCuentaPercepcionIIBBCompras,
 @PlantillaRetencionIIBB,
 @IdCuentaSIRCREB,
 @EsAgenteRetencionIIBB,
 @IdCuentaPercepcionIIBBComprasJurisdiccionLocal,
 @CodigoESRI,
 @Codigo2,
 @IdCuentaRetencionIBrutos2,
 @ProximoNumeroCertificadoRetencionIIBB2
)

SELECT @IdProvincia=@@identity

RETURN(@IdProvincia)