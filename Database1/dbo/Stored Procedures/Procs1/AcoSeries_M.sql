































CREATE  Procedure [dbo].[AcoSeries_M]
@IdAcoSerie int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoSeries
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoSerie=@IdAcoSerie)
Return(@IdAcoSerie)
































