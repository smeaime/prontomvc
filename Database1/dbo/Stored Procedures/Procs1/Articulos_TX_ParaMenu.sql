


































CREATE Procedure [dbo].[Articulos_TX_ParaMenu]
as
Select 
Articulos.IdRubro,Rubros.Descripcion as [Rubro],
Articulos.IdSubrubro,Subrubros.Descripcion as [Subrubro],
Articulos.IdFamilia,Familias.Descripcion as [Familia],
Articulos.IdArticulo,Articulos.Descripcion
From Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
LEFT OUTER JOIN Familias ON Articulos.IdFamilia = Familias.IdFamilia
order by Rubros.Descripcion,Subrubros.Descripcion,Familias.Descripcion,Articulos.Descripcion



































