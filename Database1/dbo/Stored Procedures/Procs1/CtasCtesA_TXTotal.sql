
CREATE Procedure [dbo].[CtasCtesA_TXTotal]

@IdProveedor int,
@Todo int,
@FechaLimite datetime,
@Consolidar int = Null

AS 

SET @Consolidar=IsNull(@Consolidar,-1)

SELECT SUM(CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1) as [SaldoCta]
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE CtaCte.IdProveedor=@IdProveedor and (@Todo=-1 or CtaCte.Fecha<=@FechaLimite)
GROUP by CtaCte.IdProveedor
