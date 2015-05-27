


































CREATE Procedure [dbo].[Articulos_TX_PorGrupo]
@IdRubro int,
@IdSubrubro int,
@IdFamilia int
as
Select IdArticulo,Descripcion
From Articulos
where (IdRubro=@IdRubro or @IdRubro=-1) and (IdSubrubro=@IdSubrubro or @IdSubrubro=-1) and (IdFamilia=@IdFamilia or @IdFamilia=-1)
order by Descripcion



































