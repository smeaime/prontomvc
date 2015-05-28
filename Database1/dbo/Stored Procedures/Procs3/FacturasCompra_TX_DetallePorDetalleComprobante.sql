





























CREATE Procedure [dbo].[FacturasCompra_TX_DetallePorDetalleComprobante]
@TipoComprobante int,
@IdDetalleComprobante int
AS 
Select 
IdFacturaCompra,
NumeroItem,
Proveedores.RazonSocial as [Proveedor],
NumeroFactura1,
NumeroFactura2,
FechaFactura,
ImporteFactura
FROM FacturasCompra
LEFT OUTER JOIN Proveedores ON FacturasCompra.IdProveedor = Proveedores.IdProveedor
Where TipoComprobante=@TipoComprobante and IdDetalleComprobante=@IdDetalleComprobante
Order By FechaFactura






























