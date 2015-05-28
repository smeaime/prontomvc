































CREATE Procedure [dbo].[AcoGrados_A]
@IdAcoGrado int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoGrados]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoGrado=@@identity
Return(@IdAcoGrado)
































