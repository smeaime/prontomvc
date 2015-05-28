


































CREATE Procedure [dbo].[Articulos_TX_AgrupadoPorSubrubro]
@IdRubro int
as
Select Articulos.IdSubrubro,Subrubros.Descripcion
From Articulos
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
where Articulos.IdRubro=@IdRubro or @IdRubro=-1
group by Articulos.IdSubrubro,Subrubros.Descripcion
order by Subrubros.Descripcion



































