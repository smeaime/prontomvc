































CREATE Procedure [dbo].[AcoModelos_A]
@IdAcoModelo int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoModelos]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoModelo=@@identity
Return(@IdAcoModelo)
































