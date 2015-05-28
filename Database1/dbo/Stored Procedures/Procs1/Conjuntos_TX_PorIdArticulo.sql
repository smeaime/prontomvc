




CREATE PROCEDURE [dbo].[Conjuntos_TX_PorIdArticulo]
@IdArticulo int
AS
SELECT *
FROM Conjuntos 
WHERE (IdArticulo = @IdArticulo)





