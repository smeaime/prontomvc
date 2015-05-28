CREATE  Procedure [dbo].[Provincias_M]

@IdProvincia int ,
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
@CodigoESRI varchar(2),
@Codigo2 int,
@IdCuentaRetencionIBrutos2 int,
@ProximoNumeroCertificadoRetencionIIBB2 int

AS

UPDATE Provincias
SET 
 Nombre=@Nombre,
 Codigo=@Codigo,
 IdPais=@IdPais,
 ProximoNumeroCertificadoRetencionIIBB=@ProximoNumeroCertificadoRetencionIIBB,
 IdCuentaRetencionIBrutos=@IdCuentaRetencionIBrutos,
 TipoRegistro=@TipoRegistro,
 IdCuentaPercepcionIBrutos=@IdCuentaPercepcionIBrutos,
 ProximoNumeroCertificadoPercepcionIIBB=@ProximoNumeroCertificadoPercepcionIIBB,
 TipoRegistroPercepcion=@TipoRegistroPercepcion,
 IdCuentaRetencionIBrutosCobranzas=@IdCuentaRetencionIBrutosCobranzas,
 IdCuentaPercepcionIIBBConvenio=@IdCuentaPercepcionIIBBConvenio,
 ExportarConApertura=@ExportarConApertura,
 EnviarEmail=@EnviarEmail,
 InformacionAuxiliar=@InformacionAuxiliar,
 IdCuentaPercepcionIIBBCompras=@IdCuentaPercepcionIIBBCompras,
 PlantillaRetencionIIBB=@PlantillaRetencionIIBB,
 IdCuentaSIRCREB=@IdCuentaSIRCREB,
 EsAgenteRetencionIIBB=@EsAgenteRetencionIIBB,
 IdCuentaPercepcionIIBBComprasJurisdiccionLocal=@IdCuentaPercepcionIIBBComprasJurisdiccionLocal,
 CodigoESRI=@CodigoESRI,
 Codigo2=@Codigo2,
 IdCuentaRetencionIBrutos2=@IdCuentaRetencionIBrutos2,
 ProximoNumeroCertificadoRetencionIIBB2=@ProximoNumeroCertificadoRetencionIIBB2
WHERE (IdProvincia=@IdProvincia)

RETURN(@IdProvincia)