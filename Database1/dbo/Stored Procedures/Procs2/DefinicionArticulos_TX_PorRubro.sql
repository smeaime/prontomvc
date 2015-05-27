
CREATE PROCEDURE [dbo].[DefinicionArticulos_TX_PorRubro]

@IdRubro int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	
			(
			 A_IdDef INTEGER,
			 A_IdRubro INTEGER,
			 A_Rubro VARCHAR(50),
			 A_IdSubrubro INTEGER,
			 A_Subrubro VARCHAR(50),
			 A_IdFamilia INTEGER,
			 A_Familia VARCHAR(50),
			 A_Campo VARCHAR(50)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DefArt.IdDef,
  DefArt.IdRubro,
  Rubros.Descripcion ,
  DefArt.IdSubrubro,
  Subrubros.Descripcion ,
  DefArt.IdFamilia,
  Familias.Descripcion ,
  DefArt.Campo
 FROM DefinicionArticulos DefArt
 LEFT OUTER JOIN Rubros ON  DefArt.IdRubro = Rubros.IdRubro 
 LEFT OUTER JOIN Subrubros ON  DefArt.IdSubrubro = Subrubros.IdSubrubro 
 LEFT OUTER JOIN Familias ON  DefArt.IdFamilia = Familias.IdFamilia

SET NOCOUNT OFF

SELECT 
 str(A_IdRubro) + '|' + str(A_IdSubrubro) + '|' + str(A_IdFamilia) + '|' as [Clave],
 A_Rubro + ' ' + A_Subrubro + ' ' + A_Familia as [Titulo]
FROM #Auxiliar1
WHERE IdRubro=@IdRubro
GROUP by A_IdRubro,A_Rubro,A_IdSubrubro,A_Subrubro,A_IdFamilia,A_Familia
ORDER BY [Titulo]

DROP TABLE #Auxiliar1
