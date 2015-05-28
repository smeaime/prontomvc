
CREATE PROCEDURE [dbo].[Conjuntos_CalcularCostoConjuntoDesdeComponente]

@IdArticuloDetalle int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (IdArticulo INTEGER)
INSERT INTO #Auxiliar1 
 SELECT DISTINCT Conjuntos.IdArticulo 
 FROM DetalleConjuntos det
 LEFT OUTER JOIN Conjuntos ON Conjuntos.IdConjunto=det.IdConjunto
 WHERE det.IdArticulo=@IdArticuloDetalle

CREATE TABLE #Auxiliar2 
			(
			 IdArticuloDetalle INTEGER,
			 Cantidad NUMERIC(18,3),
			 CostoPPP NUMERIC(18,2),
			 CostoReposicion NUMERIC(18,2),
			 CostoPPPDolar NUMERIC(18,2),
			 CostoReposicionDolar NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdArticuloDetalle) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdArticulo int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY  FOR SELECT IdArticulo FROM #Auxiliar1 ORDER BY IdArticulo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdArticulo
WHILE @@FETCH_STATUS = 0
   BEGIN
	TRUNCATE TABLE #Auxiliar2
	INSERT INTO #Auxiliar2 
	 SELECT det.IdArticulo,det.Cantidad,IsNull(Articulos.CostoPPP,0), IsNull(Articulos.CostoReposicion,0),IsNull(Articulos.CostoPPPDolar,0),  IsNull(Articulos.CostoReposicionDolar,0)
	 FROM DetalleConjuntos det
	 LEFT OUTER JOIN Conjuntos ON Conjuntos.IdConjunto=det.IdConjunto
	 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=det.IdArticulo
	 WHERE Conjuntos.IdArticulo=@IdArticulo

	UPDATE Articulos
	SET 	CostoPPP=IsNull((Select Sum(CostoPPP*Cantidad) From #Auxiliar2),0),
		CostoReposicion=IsNull((Select Sum(CostoReposicion*Cantidad) From #Auxiliar2),0),
		CostoPPPDolar=IsNull((Select Sum(CostoPPPDolar*Cantidad) From #Auxiliar2),0),
		CostoReposicionDolar=IsNull((Select Sum(CostoReposicionDolar*Cantidad) From #Auxiliar2),0)
	WHERE IdArticulo=@IdArticulo

	FETCH NEXT FROM Cur INTO @IdArticulo
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2

SET NOCOUNT OFF
