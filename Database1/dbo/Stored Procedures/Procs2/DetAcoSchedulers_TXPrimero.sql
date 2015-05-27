





























CREATE Procedure [dbo].[DetAcoSchedulers_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoSchedulers.IdDetalleAcoScheduler,
DetalleAcoSchedulers.IdScheduler,
Scheduler.Descripcion as Scheduler,
DetalleAcoSchedulers.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoSchedulers
INNER JOIN Scheduler ON DetalleAcoSchedulers.IdScheduler = Scheduler.IdScheduler






























