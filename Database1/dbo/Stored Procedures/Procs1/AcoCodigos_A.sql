































CREATE Procedure [dbo].[AcoCodigos_A]
@IdAcoCodigo int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoCodigos]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoCodigo=@@identity
Return(@IdAcoCodigo)
































