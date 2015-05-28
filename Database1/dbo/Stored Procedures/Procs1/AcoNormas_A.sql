































CREATE Procedure [dbo].[AcoNormas_A]
@IdAcoNorma int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoNormas]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoNorma=@@identity
Return(@IdAcoNorma)
































