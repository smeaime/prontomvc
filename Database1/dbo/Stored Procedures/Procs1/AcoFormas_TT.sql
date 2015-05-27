































CREATE Procedure [dbo].[AcoFormas_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoFormas.IdAcoForma,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoFormas
INNER JOIN Rubros ON AcoFormas.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoFormas.IdSubrubro = Subrubros.IdSubrubro
































