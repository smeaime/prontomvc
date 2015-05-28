































CREATE  Procedure [dbo].[AcoMarcas_M]
@IdAcoMarca int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoMarcas
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoMarca=@IdAcoMarca)
Return(@IdAcoMarca)
































