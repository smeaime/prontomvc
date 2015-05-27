




























CREATE PROCEDURE [dbo].[DefinicionArticulos_TX_Grupos]

AS

Select 
DefArt.IdRubro,
Rubros.Descripcion as Rubro,
DefArt.IdSubrubro,
Subrubros.Descripcion as Subrubro,
DefArt.IdFamilia,
Familias.Descripcion as Familia
FROM DefinicionArticulos DefArt
INNER JOIN Rubros ON  DefArt.IdRubro  = Rubros.IdRubro 
INNER JOIN Subrubros ON DefArt.IdSubrubro  = Subrubros.IdSubrubro 
INNER JOIN Familias ON DefArt.IdFamilia = Familias.IdFamilia
group by DefArt.idRubro,Rubros.Descripcion,DefArt.idSubrubro,Subrubros.Descripcion,DefArt.idFamilia,Familias.Descripcion




























