





























CREATE Procedure [dbo].[DetAcoBiselados_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoBiselados.IdDetalleAcoBiselado,
DetalleAcoBiselados.IdBiselado,
Biselados.Descripcion as Biselado,
DetalleAcoBiselados.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoBiselados
INNER JOIN Biselados ON DetalleAcoBiselados.IdBiselado = Biselados.IdBiselado






























