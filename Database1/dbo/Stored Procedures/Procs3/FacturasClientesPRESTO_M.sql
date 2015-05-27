




















CREATE Procedure [dbo].[FacturasClientesPRESTO_M]
@IdFacturaClientePRESTO int,
@IdCliente int,
@FechaIngreso datetime,
@NumeroFacturaPRESTO varchar(20),
@ImporteTotal numeric(18,2),
@Confirmado varchar(2),
@FechaConfirmacion datetime,
@IdUsuarioConfirmo int
As
Update FacturasClientesPRESTO
Set 
 IdCliente=@IdCliente,
 FechaIngreso=@FechaIngreso,
 NumeroFacturaPRESTO=@NumeroFacturaPRESTO,
 ImporteTotal=@ImporteTotal,
 Confirmado=@Confirmado,
 FechaConfirmacion=@FechaConfirmacion,
 IdUsuarioConfirmo=@IdUsuarioConfirmo
Where (IdFacturaClientePRESTO=@IdFacturaClientePRESTO)
Return(@IdFacturaClientePRESTO)





















