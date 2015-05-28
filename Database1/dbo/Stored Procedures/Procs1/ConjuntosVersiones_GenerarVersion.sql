CREATE Procedure [dbo].[ConjuntosVersiones_GenerarVersion]

@IdConjunto int

AS

SET NOCOUNT ON

DECLARE @IdArticulo int, @Version int, @Fecha as datetime

SET @IdArticulo=IsNull((Select Top 1 IdArticulo From Conjuntos Where IdConjunto=@IdConjunto),0)
SET @Version=IsNull((Select Top 1 Max(Version) From ConjuntosVersiones Where IdConjunto=@IdConjunto),0) + 1
SET @Fecha=GetDate()

INSERT INTO [ConjuntosVersiones] 
 SELECT @IdConjunto, IdDetalleConjunto, @IdArticulo, @Version, IdArticulo, IdUnidad, Cantidad, @Fecha
 FROM DetalleConjuntos
 WHERE IdConjunto=@IdConjunto

UPDATE Conjuntos
SET Version=@Version
WHERE IdConjunto=@IdConjunto

SET NOCOUNT OFF
