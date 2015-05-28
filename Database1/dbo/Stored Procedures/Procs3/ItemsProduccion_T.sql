





























CREATE Procedure [dbo].[ItemsProduccion_T]
@IdItemProduccion int
AS 
SELECT IdItemProduccion, Descripcion
FROM ItemsProduccion
where (IdItemProduccion=@IdItemProduccion)






























