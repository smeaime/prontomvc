































CREATE Procedure [dbo].[AcoCalidades_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoCalidades.IdAcoCalidad,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoCalidades
INNER JOIN Rubros ON AcoCalidades.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoCalidades.IdSubrubro = Subrubros.IdSubrubro
































