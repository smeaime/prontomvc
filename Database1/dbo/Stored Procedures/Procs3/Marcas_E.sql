CREATE Procedure [dbo].[Marcas_E]

@IdMarca int  

AS 

DELETE Marcas
WHERE (IdMarca=@IdMarca)