


CREATE Procedure [dbo].[CtasCtesD_TX_PorIdOrigen]
@IdCtaCteOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdCtaCte
FROM CuentasCorrientesDeudores
WHERE IdCtaCteOriginal=@IdCtaCteOriginal and IdOrigenTransmision=@IdOrigenTransmision


