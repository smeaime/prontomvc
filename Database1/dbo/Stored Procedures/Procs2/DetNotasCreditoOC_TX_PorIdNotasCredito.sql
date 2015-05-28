



















CREATE Procedure [dbo].[DetNotasCreditoOC_TX_PorIdNotasCredito]
@IdNotaCredito int
AS 
SELECT 
 DetNC_OC.*
FROM DetalleNotasCreditoOrdenesCompra DetNC_OC
WHERE (DetNC_OC.IdNotaCredito = @IdNotaCredito)




















