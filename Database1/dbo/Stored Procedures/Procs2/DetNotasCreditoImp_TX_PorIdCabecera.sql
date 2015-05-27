


















CREATE PROCEDURE [dbo].[DetNotasCreditoImp_TX_PorIdCabecera]
@IdNotaCredito int
AS
SELECT *
FROM DetalleNotasCreditoImputaciones 
WHERE (DetalleNotasCreditoImputaciones.IdNotaCredito = @IdNotaCredito)


















