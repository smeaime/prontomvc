


































CREATE Procedure [dbo].[Articulos_TX_Clave]
@IdArticulo int
AS 
SELECT
Convert(varchar,idRubro)+'|'+Convert(varchar,idSubrubro)+'|'+Convert(varchar,idFamilia)+'|' as [Clave]
FROM Articulos
WHERE (IdArticulo=@IdArticulo)



































