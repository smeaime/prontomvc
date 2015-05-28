CREATE Procedure [dbo].[CtasCtesD_TX_BuscarComprobante]

@IdComprobante int,
@IdTipoComp int

AS 

SELECT *
FROM CuentasCorrientesDeudores
WHERE (IdComprobante=@IdComprobante and IdTipoComp=@IdTipoComp)