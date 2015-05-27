


CREATE Procedure [dbo].[CtasCtesA_TX_PorNumeroInterno]
@NumeroComprobante int
AS 
SELECT CtaCte.*
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE CtaCte.NumeroComprobante=@NumeroComprobante and TiposComprobante.Coeficiente>0


