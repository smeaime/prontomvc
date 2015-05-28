





























CREATE Procedure [dbo].[Schedulers_A]
@IdScheduler int  output,
@Descripcion varchar(50)
AS 
Insert into [Scheduler]
(Descripcion)
Values(@Descripcion)
Select @IdScheduler=@@identity
Return(@IdScheduler)






























