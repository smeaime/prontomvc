































CREATE  Procedure [dbo].[AcoMateriales_M]
@IdAcoMaterial int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoMateriales
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoMaterial=@IdAcoMaterial)
Return(@IdAcoMaterial)
































