





























CREATE  Procedure [dbo].[FacturasCompra_M]
@IdFacturaCompra int ,
@TipoComprobante int,
@IdComprobante int,
@IdDetalleComprobante int,
@NumeroItem int,
@IdProveedor int,
@NumeroFactura1 int,
@NumeroFactura2 int,
@FechaFactura datetime,
@ImporteFactura numeric(12,2),
@Usuario varchar(6),
@FechaIngreso datetime,
@IdMoneda int
AS
Update FacturasCompra
SET
 TipoComprobante=@TipoComprobante,
 IdComprobante=@IdComprobante,
 IdDetalleComprobante=@IdDetalleComprobante,
 NumeroItem=@NumeroItem,
 IdProveedor=@IdProveedor,
 NumeroFactura1=@NumeroFactura1,
 NumeroFactura2=@NumeroFactura2,
 FechaFactura=@FechaFactura,
 ImporteFactura=@ImporteFactura,
 Usuario=@Usuario,
 FechaIngreso=@FechaIngreso,
 IdMoneda=@IdMoneda
Where (IdFacturaCompra=@IdFacturaCompra)
Return(@IdFacturaCompra)






























