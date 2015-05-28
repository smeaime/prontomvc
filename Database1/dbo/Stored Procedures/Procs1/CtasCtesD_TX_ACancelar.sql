
































CREATE Procedure [dbo].[CtasCtesD_TX_ACancelar]
@IdCliente int
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
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
where (CtaCte.IdCliente=@IdCliente and TiposComprobante.Coeficiente=1 and CtaCte.Saldo<>0)
order by CtaCte.IdImputacion,CtaCte.Fecha

































