





























CREATE Procedure [dbo].[EstadoPedidos_TT]
AS 
Select 
EstadoPedidos.IdProveedor,
Proveedores.RazonSocial as [Proveedor]
FROM EstadoPedidos 
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=EstadoPedidos.IdProveedor
group by Proveedores.RazonSocial,EstadoPedidos.IdProveedor
order by Proveedores.RazonSocial






























