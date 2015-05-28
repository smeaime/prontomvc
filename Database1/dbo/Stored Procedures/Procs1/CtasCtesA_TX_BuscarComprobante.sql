
CREATE Procedure [dbo].[CtasCtesA_TX_BuscarComprobante]

@IdComprobante int,
@IdTipoComp int

AS 

SELECT *
FROM CuentasCorrientesAcreedores
WHERE (IdComprobante=@IdComprobante and IdTipoComp=@IdTipoComp)
