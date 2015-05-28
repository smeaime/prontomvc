































CREATE  Procedure [dbo].[AcoTipos_M]
@IdAcoTipo int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoTipos
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoTipo=@IdAcoTipo)
Return(@IdAcoTipo)
































