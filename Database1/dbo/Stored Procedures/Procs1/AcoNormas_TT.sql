































CREATE Procedure [dbo].[AcoNormas_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoNormas.IdAcoNorma,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoNormas
INNER JOIN Rubros ON AcoNormas.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoNormas.IdSubrubro = Subrubros.IdSubrubro
































