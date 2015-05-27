





























CREATE Procedure [dbo].[DetAcoAcabados_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoAcabados.IdDetalleAcoAcabado,
DetalleAcoAcabados.IdAcabado,
Acabados.Descripcion as Acabado,
DetalleAcoAcabados.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoAcabados
INNER JOIN Acabados ON DetalleAcoAcabados.IdAcabado = Acabados.IdAcabado






























