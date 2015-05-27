
CREATE Procedure [dbo].[CtasCtesD_TX_PorId]

@IdCtaCte int

AS 

SELECT *
FROM CuentasCorrientesDeudores
WHERE (IdCtaCte=@IdCtaCte)
