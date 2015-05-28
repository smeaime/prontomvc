































CREATE Procedure [dbo].[AcoGrados_TX_TT]
@IdAcoGrado int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoGrados.IdAcoGrado,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoGrados
INNER JOIN Rubros ON AcoGrados.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoGrados.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoGrado=@IdAcoGrado)
































