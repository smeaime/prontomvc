CREATE Procedure [dbo].[Marcas_T]

@IdMarca int

AS 

SELECT *
FROM Marcas
WHERE (IdMarca=@IdMarca)