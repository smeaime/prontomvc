




















CREATE Procedure [dbo].[FacturasClientesPRESTO_TX_PorId]
@IdFacturaClientePRESTO int
AS 
SELECT *
FROM FacturasClientesPRESTO
WHERE (IdFacturaClientePRESTO=@IdFacturaClientePRESTO)





















