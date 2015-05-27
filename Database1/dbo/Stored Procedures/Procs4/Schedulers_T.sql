





























CREATE Procedure [dbo].[Schedulers_T]
@IdScheduler int
AS 
SELECT IdScheduler, Descripcion
FROM Scheduler
where (IdScheduler=@IdScheduler)






























