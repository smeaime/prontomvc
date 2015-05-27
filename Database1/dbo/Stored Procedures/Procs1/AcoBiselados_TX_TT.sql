































CREATE Procedure [dbo].[AcoBiselados_TX_TT]
@IdAcoBiselado int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoBiselados.IdAcoBiselado,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoBiselados
INNER JOIN Rubros ON AcoBiselados.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoBiselados.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoBiselado=@IdAcoBiselado)
































