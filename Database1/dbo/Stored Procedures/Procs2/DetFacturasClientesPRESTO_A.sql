




















CREATE Procedure [dbo].[DetFacturasClientesPRESTO_A]
@IdDetalleFacturaClientePRESTO int  output,
@IdFacturaClientePRESTO int,
@IdArticulo int,
@Cantidad numeric(18,2),
@Importe numeric(12,2),
@Observaciones ntext
AS 
Insert into [DetalleFacturasClientesPRESTO]
(
 IdFacturaClientePRESTO,
 IdArticulo,
 Cantidad,
 Importe,
 Observaciones
)
Values
(
 @IdFacturaClientePRESTO,
 @IdArticulo,
 @Cantidad,
 @Importe,
 @Observaciones
)
Select @IdDetalleFacturaClientePRESTO=@@identity
Return(@IdDetalleFacturaClientePRESTO)





















