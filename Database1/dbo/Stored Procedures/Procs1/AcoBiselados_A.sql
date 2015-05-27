































CREATE Procedure [dbo].[AcoBiselados_A]
@IdAcoBiselado int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoBiselados]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoBiselado=@@identity
Return(@IdAcoBiselado)
































