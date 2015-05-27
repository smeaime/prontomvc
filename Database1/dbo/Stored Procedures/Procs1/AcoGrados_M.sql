































CREATE  Procedure [dbo].[AcoGrados_M]
@IdAcoGrado int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoGrados
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoGrado=@IdAcoGrado)
Return(@IdAcoGrado)
































