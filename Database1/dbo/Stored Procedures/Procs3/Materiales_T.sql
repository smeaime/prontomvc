





























CREATE Procedure [dbo].[Materiales_T]
@IdMaterial int
AS 
SELECT IdMaterial, Descripcion
FROM Materiales
where (IdMaterial=@IdMaterial)






























