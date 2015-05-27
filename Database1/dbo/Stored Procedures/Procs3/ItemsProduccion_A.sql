





























CREATE Procedure [dbo].[ItemsProduccion_A]
@IdItemProduccion int  output,
@Descripcion varchar(50)
AS 
Insert into [ItemsProduccion]
(Descripcion)
Values(@Descripcion)
Select @IdItemProduccion=@@identity
Return(@IdItemProduccion)






























