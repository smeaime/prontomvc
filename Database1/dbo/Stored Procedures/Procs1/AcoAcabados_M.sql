































CREATE  Procedure [dbo].[AcoAcabados_M]
@IdAcoAcabado int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoAcabados
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoAcabado=@IdAcoAcabado)
Return(@IdAcoAcabado)
































