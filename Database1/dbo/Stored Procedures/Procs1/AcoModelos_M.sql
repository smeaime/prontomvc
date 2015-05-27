































CREATE  Procedure [dbo].[AcoModelos_M]
@IdAcoModelo int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoModelos
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoModelo=@IdAcoModelo)
Return(@IdAcoModelo)
































