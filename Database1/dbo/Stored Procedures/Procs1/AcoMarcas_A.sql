































CREATE Procedure [dbo].[AcoMarcas_A]
@IdAcoMarca int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoMarcas]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoMarca=@@identity
Return(@IdAcoMarca)
































