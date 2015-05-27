































CREATE Procedure [dbo].[AcoMateriales_TX_TT]
@IdAcoMaterial int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoMateriales.IdAcoMaterial,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoMateriales
INNER JOIN Rubros ON AcoMateriales.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoMateriales.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoMaterial=@IdAcoMaterial)
































