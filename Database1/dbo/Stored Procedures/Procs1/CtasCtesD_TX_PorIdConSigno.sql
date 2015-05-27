




CREATE Procedure [dbo].[CtasCtesD_TX_PorIdConSigno]
@IdCtaCte int
AS 
SELECT 
 CtaCte.*,
 TiposComprobante.Coeficiente
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE (IdCtaCte=@IdCtaCte)




