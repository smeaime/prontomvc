































CREATE  Procedure [dbo].[AcoFormas_M]
@IdAcoForma int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoFormas
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoForma=@IdAcoForma)
Return(@IdAcoForma)
































