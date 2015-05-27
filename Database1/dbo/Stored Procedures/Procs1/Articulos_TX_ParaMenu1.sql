



CREATE Procedure [dbo].[Articulos_TX_ParaMenu1]
AS
SELECT
 IsNull(Articulos.IdRubro,0) as [IdRubro],
 Rubros.Descripcion as [Rubro],
 IsNull(Articulos.IdSubrubro,0) as [IdSubrubro],
 Subrubros.Descripcion as [Subrubro],
 IsNull(Articulos.IdFamilia,0) as [IdFamilia],
 Familias.Descripcion as [Familia],
 Articulos.IdArticulo,
 Articulos.Descripcion
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
LEFT OUTER JOIN Familias ON Articulos.IdFamilia = Familias.IdFamilia
ORDER BY Articulos.IdRubro,Articulos.IdSubrubro,Articulos.Descripcion



