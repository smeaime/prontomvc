































CREATE Procedure [dbo].[AcoSchedulers_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoSchedulers.IdScheduler, 
Scheduler.Descripcion as Titulo
FROM DetalleAcoSchedulers 
INNER JOIN AcoSchedulers ON DetalleAcoSchedulers.IdAcoScheduler = AcoSchedulers.IdAcoScheduler 
INNER JOIN Scheduler ON DetalleAcoSchedulers.IdScheduler = Scheduler.IdScheduler
WHERE AcoSchedulers.IdRubro = @Rubro AND AcoSchedulers.IdSubRubro = @Subrubro
































