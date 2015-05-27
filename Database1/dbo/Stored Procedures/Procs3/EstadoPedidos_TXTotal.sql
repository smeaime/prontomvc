





























CREATE Procedure [dbo].[EstadoPedidos_TXTotal]
@IdProveedor int
AS 
Select 
SUM(EstadoPedidos.ImporteTotal*TiposComprobante.Coeficiente) as [Saldo Cta.]
FROM EstadoPedidos 
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=EstadoPedidos.IdTipoComprobante
WHERE (EstadoPedidos.IdProveedor=@IdProveedor)
GROUP by EstadoPedidos.IdProveedor






























