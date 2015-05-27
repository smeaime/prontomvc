































CREATE Procedure [dbo].[AcoColores_A]
@IdAcoColor int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoColores]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoColor=@@identity
Return(@IdAcoColor)
































