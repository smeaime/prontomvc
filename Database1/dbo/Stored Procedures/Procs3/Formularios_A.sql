





























CREATE Procedure [dbo].[Formularios_A]
@IdFormulario int  output,
@Descripcion varchar(50)
AS 
Insert into [Formularios]
(Descripcion)
Values(@Descripcion)
Select @IdFormulario=@@identity
Return(@IdFormulario)






























