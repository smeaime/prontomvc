


























CREATE PROCEDURE [dbo].[Conjuntos_TX_DetallesPorId]
@IdConjunto int
AS
SELECT *
FROM DetalleConjuntos 
WHERE (DetalleConjuntos.IdConjunto = @IdConjunto)



























