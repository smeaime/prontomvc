
CREATE PROCEDURE [dbo].[DefinicionArticulos_TL]

AS

SELECT Convert(varchar,idRubro) + '|' + Convert(varchar,idSubrubro) + '|' + '1' + '|' as [Clave],
	(Select Rubros.Descripcion From Rubros Where DefArt.IdRubro=Rubros.IdRubro) + ' ' +
	(Select Subrubros.Descripcion From Subrubros Where DefArt.IdSubrubro=Subrubros.IdSubrubro) as [Titulo]
FROM DefinicionArticulos DefArt
GROUP BY idRubro,idSubrubro
ORDER BY [Titulo]
