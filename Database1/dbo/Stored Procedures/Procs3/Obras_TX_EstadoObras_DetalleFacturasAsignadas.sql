









CREATE Procedure [dbo].[Obras_TX_EstadoObras_DetalleFacturasAsignadas]
@TipoComprobante int,
@IdDetalleComprobante int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='026545000'
Select 
IdFacturaCompra,
NumeroItem as [Item],
Proveedores.RazonSocial as [Proveedor],
str(NumeroFactura1,4)+'-'+str(NumeroFactura2,8) as [Nro.factura],
FechaFactura as [Fecha fac.],
ImporteFactura as [Imp.Factura s/iva],
Monedas.Nombre as [Moneda],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM FacturasCompra
LEFT OUTER JOIN Proveedores ON FacturasCompra.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON FacturasCompra.IdMoneda = Monedas.IdMoneda
Where TipoComprobante=@TipoComprobante and IdDetalleComprobante=@IdDetalleComprobante
Order by FechaFactura









