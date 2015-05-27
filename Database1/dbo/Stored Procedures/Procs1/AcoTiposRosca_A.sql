































CREATE Procedure [dbo].[AcoTiposRosca_A]
@IdAcoTipoRosca int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoTiposRosca]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoTipoRosca=@@identity
Return(@IdAcoTipoRosca)
































