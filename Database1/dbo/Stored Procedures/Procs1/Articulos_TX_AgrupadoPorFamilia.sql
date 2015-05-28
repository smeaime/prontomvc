


































CREATE Procedure [dbo].[Articulos_TX_AgrupadoPorFamilia]
@IdRubro int,
@IdSubrubro int
as
Select Articulos.IdFamilia,Familias.Descripcion
From Articulos
LEFT OUTER JOIN Familias ON Articulos.IdFamilia = Familias.IdFamilia
where (Articulos.IdRubro=@IdRubro or @IdRubro=-1) and (Articulos.IdSubrubro=@IdSubrubro or @IdSubrubro=-1)
group by Articulos.IdFamilia,Familias.Descripcion
order by Familias.Descripcion



































