




















CREATE  Procedure [dbo].[FacturasClientesPRESTO_TT]
AS 
SELECT 
	FacturasClientesPRESTO.IdFacturaClientePRESTO, 
	FacturasClientesPRESTO.NumeroFacturaPRESTO as [Factura], 
	Clientes.CodigoCliente as [Cod.Cli.], 
	Clientes.RazonSocial as [Cliente], 
	Clientes.Cuit as [Cuit], 
	FacturasClientesPRESTO.FechaIngreso as [Fecha ingreso], 
	FacturasClientesPRESTO.ImporteTotal as [Total factura],
	FacturasClientesPRESTO.Confirmado as [Confirmado]
FROM FacturasClientesPRESTO 
LEFT OUTER JOIN Clientes ON FacturasClientesPRESTO.IdCliente = Clientes.IdCliente
ORDER BY FacturasClientesPRESTO.FechaIngreso,
	FacturasClientesPRESTO.NumeroFacturaPRESTO





















