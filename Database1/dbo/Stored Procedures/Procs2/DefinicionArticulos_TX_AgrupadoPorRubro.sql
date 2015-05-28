





















CREATE Procedure [dbo].[DefinicionArticulos_TX_AgrupadoPorRubro]
AS
SELECT DefinicionArticulos.IdRubro,Rubros.Descripcion
FROM DefinicionArticulos
LEFT OUTER JOIN Rubros ON DefinicionArticulos.IdRubro = Rubros.IdRubro
GROUP by DefinicionArticulos.IdRubro,Rubros.Descripcion
ORDER by Rubros.Descripcion






















