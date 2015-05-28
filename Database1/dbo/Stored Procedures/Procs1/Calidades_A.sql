





























CREATE Procedure [dbo].[Calidades_A]
@IdCalidad int  output,
@Descripcion varchar(50)
AS 
Insert into [Calidades]
(Descripcion)
Values(@Descripcion)
Select @IdCalidad=@@identity
Return(@IdCalidad)






























