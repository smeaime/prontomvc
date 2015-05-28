





























CREATE Procedure [dbo].[FacturasCompra_A]
@IdFacturaCompra int  output,
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
Insert into [FacturasCompra]
(
 TipoComprobante,
 IdComprobante,
 IdDetalleComprobante,
 NumeroItem,
 IdProveedor,
 NumeroFactura1,
 NumeroFactura2,
 FechaFactura,
 ImporteFactura,
 Usuario,
 FechaIngreso,
 IdMoneda
)
Values
(
 @TipoComprobante,
 @IdComprobante,
 @IdDetalleComprobante,
 @NumeroItem,
 @IdProveedor,
 @NumeroFactura1,
 @NumeroFactura2,
 @FechaFactura,
 @ImporteFactura,
 @Usuario,
 @FechaIngreso,
 @IdMoneda
)
Select @IdFacturaCompra=@@identity
Return(@IdFacturaCompra)






























