




















CREATE Procedure [dbo].[FacturasClientesPRESTO_E]
@IdFacturaClientePRESTO int
AS 
Delete FacturasClientesPRESTO
Where (IdFacturaClientePRESTO=@IdFacturaClientePRESTO)





















