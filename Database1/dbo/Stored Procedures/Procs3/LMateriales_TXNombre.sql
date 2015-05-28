





























CREATE  Procedure [dbo].[LMateriales_TXNombre]
@Nombre varchar(30)
AS 
SELECT 
	LMateriales.IdLMateriales,
	LMateriales.NumeroLMateriales,
	LMateriales.Nombre,
	LMateriales.Fecha
FROM LMateriales
WHERE (LMateriales.Nombre=@Nombre)






























