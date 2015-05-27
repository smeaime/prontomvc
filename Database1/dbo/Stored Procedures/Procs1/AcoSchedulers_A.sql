































CREATE Procedure [dbo].[AcoSchedulers_A]
@IdAcoScheduler int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoSchedulers]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoScheduler=@@identity
Return(@IdAcoScheduler)
































