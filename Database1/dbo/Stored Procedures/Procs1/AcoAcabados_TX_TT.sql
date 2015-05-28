































CREATE Procedure [dbo].[AcoAcabados_TX_TT]
@IdAcoAcabado int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoAcabados.IdAcoAcabado,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoAcabados
INNER JOIN Rubros ON AcoAcabados.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoAcabados.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoAcabado=@IdAcoAcabado)
































