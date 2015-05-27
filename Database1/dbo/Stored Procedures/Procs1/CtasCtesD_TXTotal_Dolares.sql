




CREATE Procedure [dbo].[CtasCtesD_TXTotal_Dolares]
@IdCliente int,
@Todo int,
@FechaLimite datetime
AS 
SELECT 
 SUM(CtaCte.ImporteTotalDolar*TiposComprobante.Coeficiente) as [SaldoCta]
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE CtaCte.IdCliente=@IdCliente and (@Todo=-1 or CtaCte.Fecha<=@FechaLimite)
GROUP by CtaCte.IdCliente




