































CREATE Procedure [dbo].[AcoSchedulers_TX_TT]
@IdAcoScheduler int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoSchedulers.IdAcoScheduler,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoSchedulers
INNER JOIN Rubros ON AcoSchedulers.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoSchedulers.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoScheduler=@IdAcoScheduler)
































