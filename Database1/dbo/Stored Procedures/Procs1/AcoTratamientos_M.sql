































CREATE  Procedure [dbo].[AcoTratamientos_M]
@IdAcoTratamiento int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoTratamientos
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoTratamiento=@IdAcoTratamiento)
Return(@IdAcoTratamiento)
































