































CREATE  Procedure [dbo].[AcoCalidades_M]
@IdAcoCalidad int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoCalidades
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoCalidad=@IdAcoCalidad)
Return(@IdAcoCalidad)
































