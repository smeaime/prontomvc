































CREATE Procedure [dbo].[AcoFormas_A]
@IdAcoForma int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoFormas]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoForma=@@identity
Return(@IdAcoForma)
































