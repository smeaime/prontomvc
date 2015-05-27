





























CREATE Procedure [dbo].[EstadoPedidos_TX_ACancelar]
@IdProveedor int
AS 
Select 
EstadoPedidos.IdEstado,
EstadoPedidos.IdImputacion,
EstadoPedidos.IdComprobante,
TiposComprobante.DescripcionAB,
EstadoPedidos.LetraComprobante+' '+
	CONVERT(varchar(4),EstadoPedidos.NumeroComprobante1)+' '+
	CONVERT(varchar(8),EstadoPedidos.NumeroComprobante2) as [Comprobante],
EstadoPedidos.Fecha,
EstadoPedidos.ImporteTotal,
EstadoPedidos.Saldo
FROM EstadoPedidos 
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=EstadoPedidos.IdTipoComprobante
WHERE (EstadoPedidos.IdProveedor=@IdProveedor and TiposComprobante.Coeficiente=1 and EstadoPedidos.Saldo<>0)
ORDER by EstadoPedidos.IdImputacion,EstadoPedidos.Fecha






























