





























CREATE Procedure [dbo].[FacturasCompra_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='012344400'
Select Top 1
IdFacturaCompra,
NumeroItem as [Item],
Proveedores.RazonSocial as [Proveedor],
str(NumeroFactura1,4)+'-'+str(NumeroFactura2,8) as [Nro.factura],
FechaFactura as [Fecha fac.],
ImporteFactura as [Importe],
Monedas.Nombre as [Moneda],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM FacturasCompra
LEFT OUTER JOIN Proveedores ON FacturasCompra.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON FacturasCompra.IdMoneda = Monedas.IdMoneda






























