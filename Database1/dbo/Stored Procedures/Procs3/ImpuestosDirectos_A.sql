CREATE Procedure [dbo].[ImpuestosDirectos_A]

@IdImpuestoDirecto int  output,
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

INSERT INTO [ImpuestosDirectos]
(
 Descripcion,
 Tasa,
 IdTipoImpuesto,
 IdCuenta,
 BaseMinima,
 ProximoNumeroCertificado,
 Grupo,
 ActivaNumeracionPorGrupo,
 Codigo,
 TopeAnual,
 ParaInscriptosEnRegistroFiscalOperadoresGranos,
 CodigoRegimen
)
VALUES
(
 @Descripcion,
 @Tasa,
 @IdTipoImpuesto,
 @IdCuenta,
 @BaseMinima,
 @ProximoNumeroCertificado,
 @Grupo,
 @ActivaNumeracionPorGrupo,
 @Codigo,
 @TopeAnual,
 @ParaInscriptosEnRegistroFiscalOperadoresGranos,
 @CodigoRegimen
)

SELECT @IdImpuestoDirecto=@@identity

RETURN(@IdImpuestoDirecto)