































CREATE  Procedure [dbo].[AcoCodigos_M]
@IdAcoCodigo int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoCodigos
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoCodigo=@IdAcoCodigo)
Return(@IdAcoCodigo)
































