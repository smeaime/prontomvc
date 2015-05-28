CREATE Procedure [dbo].[Marcas_TX_TT]

@IdMarca int

AS 

SELECT 
 IdMarca,
 Codigo,
 Descripcion
FROM Marcas
WHERE (IdMarca=@IdMarca)