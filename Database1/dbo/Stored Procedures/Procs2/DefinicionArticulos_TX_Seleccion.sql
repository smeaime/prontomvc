
CREATE PROCEDURE [dbo].[DefinicionArticulos_TX_Seleccion]

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
  IsNull(Familias.Descripcion,'') ,
  DefArt.Campo
 FROM DefinicionArticulos DefArt
 LEFT OUTER JOIN Rubros ON  DefArt.IdRubro = Rubros.IdRubro 
 LEFT OUTER JOIN Subrubros ON  DefArt.IdSubrubro = Subrubros.IdSubrubro 
 LEFT OUTER JOIN Familias ON  DefArt.IdFamilia = Familias.IdFamilia

SET NOCOUNT OFF

declare @Marca varchar(1), @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='00000'
set @Marca=' '

SELECT 
 str(A_IdRubro) + '|' + str(A_IdSubrubro) + '|' + str(A_IdFamilia) + '|' as [Clave],
 A_Rubro + ' ' + A_Subrubro + ' ' + A_Familia as [Agrupacion],
 @Marca as [*],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP by A_IdRubro,A_Rubro,A_IdSubrubro,A_Subrubro,A_IdFamilia,A_Familia
ORDER BY [Agrupacion]

DROP TABLE #Auxiliar1
