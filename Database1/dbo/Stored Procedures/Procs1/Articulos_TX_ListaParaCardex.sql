


































CREATE Procedure [dbo].[Articulos_TX_ListaParaCardex]
AS 
Select 
IdArticulo,
Convert(varchar,IdArticulo)+' - '+Descripcion as [Titulo]
FROM Articulos
ORDER by Descripcion



































