































CREATE Procedure [dbo].[AcoMateriales_A]
@IdAcoMaterial int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoMateriales]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoMaterial=@@identity
Return(@IdAcoMaterial)
































