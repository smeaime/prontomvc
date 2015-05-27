
CREATE Procedure [dbo].[CtasCtesA_TXTotal_Euros]

@IdProveedor int,
@Todo int,
@FechaLimite datetime

AS 

SELECT SUM(CtaCte.ImporteTotalEuro*TiposComprobante.Coeficiente*-1) as [SaldoCta]
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE CtaCte.IdProveedor=@IdProveedor and (@Todo=-1 or CtaCte.Fecha<=@FechaLimite)
GROUP by CtaCte.IdProveedor
