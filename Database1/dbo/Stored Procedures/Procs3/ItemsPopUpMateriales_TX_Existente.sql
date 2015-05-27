






























CREATE Procedure [dbo].[ItemsPopUpMateriales_TX_Existente]
@IdRubro int,
@IdSubrubro int,
@IdFamilia int
AS 
SELECT It.IdItemPopUpMateriales
FROM ItemsPopUpMateriales It
where (It.IdRubro=@IdRubro and It.IdSubrubro=@IdSubrubro and It.IdFamilia=@IdFamilia)































