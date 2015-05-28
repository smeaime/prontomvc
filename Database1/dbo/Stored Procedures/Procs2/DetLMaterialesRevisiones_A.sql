





























CREATE Procedure [dbo].[DetLMaterialesRevisiones_A]
@IdDetalleLMaterialesRevisiones int  output,
@IdLMateriales int,
@IdDetalleLMateriales int,
@NumeroItem int,
@Fecha datetime,
@Detalle varchar(100),
@IdRealizo int,
@FechaRealizacion datetime,
@IdAprobo int,
@FechaAprobacion datetime,
@TipoRegistro varchar(1),
@NumeroRevision varchar(10),
@EnviarEmail tinyint,
@IdLMaterialesOriginal int,
@IdDetalleLMaterialesRevisionesOriginal int,
@IdOrigenTransmision int
AS 
Insert into DetalleLMaterialesRevisiones
(
 IdLMateriales,
 IdDetalleLMateriales,
 NumeroItem,
 Fecha,
 Detalle,
 IdRealizo,
 FechaRealizacion,
 IdAprobo,
 FechaAprobacion,
 TipoRegistro,
 NumeroRevision,
 EnviarEmail,
 IdLMaterialesOriginal,
 IdDetalleLMaterialesRevisionesOriginal,
 IdOrigenTransmision
)
Values
(
 @IdLMateriales,
 @IdDetalleLMateriales,
 @NumeroItem,
 @Fecha,
 @Detalle,
 @IdRealizo,
 @FechaRealizacion,
 @IdAprobo,
 @FechaAprobacion,
 @TipoRegistro,
 @NumeroRevision,
 @EnviarEmail,
 @IdLMaterialesOriginal,
 @IdDetalleLMaterialesRevisionesOriginal,
 @IdOrigenTransmision
)
Select @IdDetalleLMaterialesRevisiones=@@identity
Return(@IdDetalleLMaterialesRevisiones)






























