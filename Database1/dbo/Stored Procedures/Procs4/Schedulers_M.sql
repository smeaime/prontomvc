





























CREATE  Procedure [dbo].[Schedulers_M]
@IdScheduler int ,
@Descripcion varchar(50)
AS
Update Scheduler
SET
Descripcion=@Descripcion
where (IdScheduler=@IdScheduler)
Return(@IdScheduler)






























