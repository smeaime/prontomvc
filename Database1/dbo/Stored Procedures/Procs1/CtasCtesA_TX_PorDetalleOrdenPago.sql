





























CREATE Procedure [dbo].[CtasCtesA_TX_PorDetalleOrdenPago]
@IdDetalleOrdenPago int
AS 
SELECT TOP 1 *
FROM CuentasCorrientesAcreedores
WHERE IdDetalleOrdenPago=@IdDetalleOrdenPago





























