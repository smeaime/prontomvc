CREATE Procedure [dbo].[CtasCtesD_TX_SaldoPorClienteEntreFechas]

@IdCliente int = Null,
@FechaInicial datetime = Null,
@FechaFinal datetime = Null,
@IdComprobante int = Null

AS 

SET @IdCliente=IsNull(@IdCliente,-1)
SET @FechaInicial=IsNull(@FechaInicial,0)
SET @FechaFinal=IsNull(@FechaFinal,0)
SET @IdComprobante=IsNull(@IdComprobante,-1)

SELECT 
 CtaCte.IdCliente as [IdCliente],
 Clientes.Codigo as [CodigoCliente],
 Clientes.RazonSocial as [Cliente],
 Sum(CtaCte.ImporteTotal*TiposComprobante.Coeficiente) as [Saldo]
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE (@IdCliente=-1 or CtaCte.IdCliente=@IdCliente) and (@FechaInicial=0 or CtaCte.Fecha Between @FechaInicial and @FechaFinal) and (@IdComprobante=-1 or CtaCte.IdComprobante<>@IdComprobante)
GROUP By CtaCte.IdCliente,Clientes.Codigo,Clientes.RazonSocial