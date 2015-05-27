




















CREATE Procedure [dbo].[DetFacturasClientesPRESTO_M]
@IdDetalleFacturaClientePRESTO int,
@IdFacturaClientePRESTO int,
@IdArticulo int,
@Cantidad numeric(9,2),
@Importe numeric(12,2),
@Observaciones ntext
As
Update DetalleFacturasClientesPRESTO
Set  
 IdFacturaClientePRESTO=@IdFacturaClientePRESTO,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 Importe=@Importe,
 Observaciones=@Observaciones
Where (IdDetalleFacturaClientePRESTO=@IdDetalleFacturaClientePRESTO)
Return(@IdDetalleFacturaClientePRESTO)





















