








CREATE Procedure [dbo].[CostosImportacion_T]
@IdCostoImportacion int
AS 
SELECT *
FROM CostosImportacion
where (IdCostoImportacion=@IdCostoImportacion)








