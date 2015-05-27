





























CREATE Procedure [dbo].[ItemsProduccion_TX_TT]
@IdItemProduccion int
AS 
Select IdItemProduccion,Descripcion
FROM ItemsProduccion
where (IdItemProduccion=@IdItemProduccion)






























