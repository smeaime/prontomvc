































CREATE  Procedure [dbo].[AcoBiselados_M]
@IdAcoBiselado int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoBiselados
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoBiselado=@IdAcoBiselado)
Return(@IdAcoBiselado)
































