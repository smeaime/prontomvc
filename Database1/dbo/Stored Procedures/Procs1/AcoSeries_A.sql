































CREATE Procedure [dbo].[AcoSeries_A]
@IdAcoSerie int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoSeries]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoSerie=@@identity
Return(@IdAcoSerie)
































