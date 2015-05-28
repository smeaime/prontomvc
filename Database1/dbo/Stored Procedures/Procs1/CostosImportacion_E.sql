








CREATE Procedure [dbo].[CostosImportacion_E]
@IdCostoImportacion int
AS 
Delete CostosImportacion
where (IdCostoImportacion=@IdCostoImportacion)








