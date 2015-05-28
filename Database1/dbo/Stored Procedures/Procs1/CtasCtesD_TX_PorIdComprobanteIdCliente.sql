
CREATE Procedure [dbo].[CtasCtesD_TX_PorIdComprobanteIdCliente]
@IdComprobante int,
@IdCliente int
AS 
SELECT *
FROM CuentasCorrientesDeudores
WHERE IdComprobante=@IdComprobante and IdCliente=@IdCliente and IdTipoComp<>16
