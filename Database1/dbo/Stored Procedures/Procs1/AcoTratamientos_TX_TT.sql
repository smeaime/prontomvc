































CREATE Procedure [dbo].[AcoTratamientos_TX_TT]
@IdAcoTratamiento int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoTratamientos.IdAcoTratamiento,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoTratamientos
INNER JOIN Rubros ON AcoTratamientos.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoTratamientos.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoTratamiento=@IdAcoTratamiento)
































