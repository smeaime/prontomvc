




















CREATE Procedure [dbo].[DetFacturasClientesPRESTO_E]
@IdDetalleFacturaClientePRESTOs int
AS 
Delete DetalleFacturasClientesPRESTO
Where (IdDetalleFacturaClientePRESTO=@IdDetalleFacturaClientePRESTOs)





















