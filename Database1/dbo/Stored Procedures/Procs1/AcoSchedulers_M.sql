































CREATE  Procedure [dbo].[AcoSchedulers_M]
@IdAcoScheduler int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoSchedulers
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoScheduler=@IdAcoScheduler)
Return(@IdAcoScheduler)
































