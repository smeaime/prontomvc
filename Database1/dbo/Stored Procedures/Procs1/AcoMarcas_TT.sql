































CREATE Procedure [dbo].[AcoMarcas_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoMarcas.IdAcoMarca,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoMarcas
INNER JOIN Rubros ON AcoMarcas.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoMarcas.IdSubrubro = Subrubros.IdSubrubro
































