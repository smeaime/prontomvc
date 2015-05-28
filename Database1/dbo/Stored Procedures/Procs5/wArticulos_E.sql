
CREATE Procedure [dbo].[wArticulos_E]

@IdArticulo int  

AS 

DELETE Articulos
WHERE (IdArticulo=@IdArticulo)

