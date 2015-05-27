
CREATE PROCEDURE [dbo].[DefinicionArticulos_TX_Copia]

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 A_IdDef INTEGER,
			 A_Rubro VARCHAR(50),
			 A_Subrubro VARCHAR(50),
			 A_Familia VARCHAR(50),
			 A_Campo VARCHAR(50)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DefArt.IdDef,
  Rubros.Descripcion ,
  Subrubros.Descripcion ,
  Familias.Descripcion ,
  DefArt.Campo
 FROM DefinicionArticulos DefArt
 LEFT OUTER JOIN Rubros ON  DefArt.IdRubro = Rubros.IdRubro 
 LEFT OUTER JOIN Subrubros ON  DefArt.IdSubrubro = Subrubros.IdSubrubro 
 LEFT OUTER JOIN Familias ON  DefArt.IdFamilia = Familias.IdFamilia

SET NOCOUNT OFF

SELECT 
 A_IdDef as [IdDef],
 A_Rubro + ' ' + A_Subrubro + ' -> ' + A_Campo as [Titulo]
FROM #Auxiliar1
ORDER BY [Titulo]

DROP TABLE #Auxiliar1
