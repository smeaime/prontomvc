


CREATE PROCEDURE [dbo].[Conjuntos_Eliminar]

@IdConjunto int

AS

DELETE FROM DetalleConjuntos
WHERE DetalleConjuntos.IdConjunto=@IdConjunto

DELETE FROM Conjuntos
WHERE Conjuntos.IdConjunto=@IdConjunto


