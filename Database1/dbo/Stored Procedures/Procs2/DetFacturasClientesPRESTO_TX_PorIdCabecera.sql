




















CREATE PROCEDURE [dbo].[DetFacturasClientesPRESTO_TX_PorIdCabecera]
@IdFacturaClientePRESTO int
AS
SELECT *
FROM DetalleFacturasClientesPRESTO DetFac
WHERE (DetFac.IdFacturaClientePRESTO = @IdFacturaClientePRESTO)





















