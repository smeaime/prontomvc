CREATE Procedure [dbo].[TiposRubrosFinancierosGrupos_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='049400'

SELECT 
 TiposRubrosFinancierosGrupos.IdTipoRubroFinancieroGrupo as [IdTipoRubroFinancieroGrupo],
 TiposRubrosFinancierosGrupos.Codigo as [Codigo],
 TiposRubrosFinancierosGrupos.IdTipoRubroFinancieroGrupo as [IdAux],
 TiposRubrosFinancierosGrupos.Descripcion as [Tipo compra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM TiposRubrosFinancierosGrupos
ORDER BY TiposRubrosFinancierosGrupos.Descripcion