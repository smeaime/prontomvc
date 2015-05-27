





























CREATE Procedure [dbo].[EstadoPedidos_TX_TT]
@IdProveedor int
AS 
Select 
EstadoPedidos.IdProveedor,
Proveedores.RazonSocial as [Proveedor]
FROM EstadoPedidos 
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=EstadoPedidos.IdProveedor
where (EstadoPedidos.IdProveedor=@IdProveedor)
group by Proveedores.RazonSocial,EstadoPedidos.IdProveedor
order by Proveedores.RazonSocial






























