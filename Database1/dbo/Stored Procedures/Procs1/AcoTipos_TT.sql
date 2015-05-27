































CREATE Procedure [dbo].[AcoTipos_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoTipos.IdAcoTipo,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoTipos
INNER JOIN Rubros ON AcoTipos.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoTipos.IdSubrubro = Subrubros.IdSubrubro
































