





























CREATE Procedure [dbo].[Schedulers_TX_TT]
@IdScheduler int
AS 
Select *
FROM Scheduler
where (IdScheduler=@IdScheduler)
order by Descripcion






























