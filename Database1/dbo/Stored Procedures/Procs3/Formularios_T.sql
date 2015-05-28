





























CREATE Procedure [dbo].[Formularios_T]
@IdFormulario int
AS 
SELECT IdFormulario, Descripcion
FROM Formularios
where (IdFormulario=@IdFormulario)






























