CREATE  Procedure [dbo].[ImpuestosDirectos_M]

@IdImpuestoDirecto int ,
@Descripcion varchar(50),
@Tasa numeric(18,4),
@IdTipoImpuesto int,
@IdCuenta int,
@BaseMinima numeric(18,2),
@ProximoNumeroCertificado int,
@Grupo int,
@ActivaNumeracionPorGrupo varchar(2),
@Codigo varchar(10),
@TopeAnual numeric(18,2),
@ParaInscriptosEnRegistroFiscalOperadoresGranos varchar(2),
@CodigoRegimen int

AS

UPDATE ImpuestosDirectos
SET
 Descripcion=@Descripcion,
 Tasa=@Tasa,
 IdTipoImpuesto=@IdTipoImpuesto,
 IdCuenta=@IdCuenta,
 BaseMinima=@BaseMinima,
 ProximoNumeroCertificado=@ProximoNumeroCertificado,
 Grupo=@Grupo,
 ActivaNumeracionPorGrupo=@ActivaNumeracionPorGrupo,
 Codigo=@Codigo,
 TopeAnual=@TopeAnual,
 ParaInscriptosEnRegistroFiscalOperadoresGranos=@ParaInscriptosEnRegistroFiscalOperadoresGranos,
 CodigoRegimen=@CodigoRegimen
WHERE (IdImpuestoDirecto=@IdImpuestoDirecto)

RETURN(@IdImpuestoDirecto)