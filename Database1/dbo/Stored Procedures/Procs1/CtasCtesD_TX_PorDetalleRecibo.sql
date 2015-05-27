


















CREATE Procedure [dbo].[CtasCtesD_TX_PorDetalleRecibo]
@IdDetalleRecibo int
AS 
SELECT TOP 1 *
FROM CuentasCorrientesDeudores
WHERE IdDetalleRecibo=@IdDetalleRecibo


















