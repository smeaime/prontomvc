




















CREATE Procedure [dbo].[FacturasClientesPRESTO_T]
@IdFacturaClientePRESTO int
AS 
SELECT *
FROM FacturasClientesPRESTO
WHERE (IdFacturaClientePRESTO=@IdFacturaClientePRESTO)





















