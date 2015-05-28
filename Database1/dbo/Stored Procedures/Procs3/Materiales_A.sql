





























CREATE Procedure [dbo].[Materiales_A]
@IdMaterial int  output,
@Descripcion varchar(50)
AS 
Insert into [Materiales]
(Descripcion)
Values(@Descripcion)
Select @IdMaterial=@@identity
Return(@IdMaterial)






























