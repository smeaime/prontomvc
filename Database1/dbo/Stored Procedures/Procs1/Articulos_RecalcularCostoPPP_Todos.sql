CREATE PROCEDURE [dbo].[Articulos_RecalcularCostoPPP_Todos]

AS

SET NOCOUNT ON

TRUNCATE TABLE CostosPromedios

CREATE TABLE #Auxiliar0 (IdArticulo INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdArticulo) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT IdArticulo
 FROM Articulos

/*  CURSOR  */
DECLARE @IdArticulo int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdArticulo FROM #Auxiliar0 ORDER BY IdArticulo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdArticulo
WHILE @@FETCH_STATUS = 0
   BEGIN
	EXEC Articulos_RecalcularCostoPPP_PorIdArticulo @IdArticulo, 'SI'
	FETCH NEXT FROM Cur INTO @IdArticulo
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DROP TABLE #Auxiliar0