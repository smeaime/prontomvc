




















CREATE Procedure [dbo].[DetFacturasClientesPRESTO_T]
@IdDetalleFacturaClientePRESTO int
AS 
SELECT *
FROM DetalleFacturasClientesPRESTO
WHERE (IdDetalleFacturaClientePRESTO=@IdDetalleFacturaClientePRESTO)





















