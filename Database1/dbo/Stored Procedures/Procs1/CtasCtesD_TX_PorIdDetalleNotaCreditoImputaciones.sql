


















CREATE Procedure [dbo].[CtasCtesD_TX_PorIdDetalleNotaCreditoImputaciones]
@IdDetalleNotaCreditoImputaciones int
AS 
SELECT TOP 1 *
FROM CuentasCorrientesDeudores
WHERE IdDetalleNotaCreditoImputaciones=@IdDetalleNotaCreditoImputaciones


















