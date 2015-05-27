































CREATE Procedure [dbo].[AcoCalidades_A]
@IdAcoCalidad int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoCalidades]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoCalidad=@@identity
Return(@IdAcoCalidad)
































