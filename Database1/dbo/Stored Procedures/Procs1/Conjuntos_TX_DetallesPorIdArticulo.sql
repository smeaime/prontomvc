CREATE PROCEDURE [dbo].[Conjuntos_TX_DetallesPorIdArticulo]

@IdArticulo int

AS

SELECT DetalleConjuntos.*, Conjuntos.IdObra
FROM DetalleConjuntos 
LEFT OUTER JOIN Conjuntos ON DetalleConjuntos.IdConjunto = Conjuntos.IdConjunto
WHERE (Conjuntos.IdArticulo = @IdArticulo)