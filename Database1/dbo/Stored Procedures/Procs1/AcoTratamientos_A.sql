































CREATE Procedure [dbo].[AcoTratamientos_A]
@IdAcoTratamiento int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoTratamientos]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoTratamiento=@@identity
Return(@IdAcoTratamiento)
































