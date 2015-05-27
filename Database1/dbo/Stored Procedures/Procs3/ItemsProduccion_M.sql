





























CREATE  Procedure [dbo].[ItemsProduccion_M]
@IdItemProduccion int ,
@Descripcion varchar(50)
AS
Update ItemsProduccion
SET
Descripcion=@Descripcion
where (IdItemProduccion=@IdItemProduccion)
Return(@IdItemProduccion)






























