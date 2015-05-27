




























CREATE Procedure [dbo].[CtasCtesA_TX_ACancelar]
@IdProveedor int
AS 
Select 
 CtaCte.IdCtaCte,
 CtaCte.IdImputacion,
 CtaCte.IdComprobante,
 TiposComprobante.DescripcionAB,
 CtaCte.NumeroComprobante,
 CtaCte.Fecha,
 CtaCte.ImporteTotal,
 CtaCte.Saldo
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE (CtaCte.IdProveedor=@IdProveedor and TiposComprobante.Coeficiente=1 and CtaCte.Saldo<>0)
ORDER by CtaCte.IdImputacion,CtaCte.Fecha




























