


















CREATE PROCEDURE [dbo].[DetNotasCreditoImp_TX_PorIdDetalleNotaCreditoImputaciones]
@IdDetalleNotaCreditoImputaciones int
AS
SELECT *
FROM DetalleNotasCreditoImputaciones 
WHERE (DetalleNotasCreditoImputaciones.IdDetalleNotaCreditoImputaciones = @IdDetalleNotaCreditoImputaciones)


















