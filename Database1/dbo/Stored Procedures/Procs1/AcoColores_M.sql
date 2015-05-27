































CREATE  Procedure [dbo].[AcoColores_M]
@IdAcoColor int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoColores
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoColor=@IdAcoColor)
Return(@IdAcoColor)
































