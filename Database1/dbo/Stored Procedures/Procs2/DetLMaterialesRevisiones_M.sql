





























CREATE Procedure [dbo].[DetLMaterialesRevisiones_M]
@IdDetalleLMaterialesRevisiones int,
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
as
Update [DetalleLMaterialesRevisiones]
SET 
IdLMateriales=@IdLMateriales,
IdDetalleLMateriales=@IdDetalleLMateriales,
NumeroItem=@NumeroItem,
Fecha=@Fecha,
Detalle=@Detalle,
IdRealizo=@IdRealizo,
FechaRealizacion=@FechaRealizacion,
IdAprobo=@IdAprobo,
FechaAprobacion=@FechaAprobacion,
TipoRegistro=@TipoRegistro,
NumeroRevision=@NumeroRevision,
EnviarEmail=@EnviarEmail,
IdLMaterialesOriginal=@IdLMaterialesOriginal,
IdDetalleLMaterialesRevisionesOriginal=@IdDetalleLMaterialesRevisionesOriginal,
IdOrigenTransmision=@IdOrigenTransmision
Where (IdDetalleLMaterialesRevisiones=@IdDetalleLMaterialesRevisiones)
Return(@IdDetalleLMaterialesRevisiones)






























