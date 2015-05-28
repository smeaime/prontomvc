































CREATE  Procedure [dbo].[AcoTiposRosca_M]
@IdAcoTipoRosca int  output,
@IdRubro int,
@IdSubrubro int
AS
Update AcoTiposRosca
SET
IdRubro=@IdRubro,
IdSubrubro=@IdSubrubro
where (IdAcoTipoRosca=@IdAcoTipoRosca)
Return(@IdAcoTipoRosca)
































