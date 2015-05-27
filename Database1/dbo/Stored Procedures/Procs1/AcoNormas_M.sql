































CREATE  Procedure [dbo].[AcoNormas_M]
@IdAcoNorma int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoNormas
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoNorma=@IdAcoNorma)
Return(@IdAcoNorma)
































