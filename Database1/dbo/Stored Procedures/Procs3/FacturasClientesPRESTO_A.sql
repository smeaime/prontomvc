




















CREATE Procedure [dbo].[FacturasClientesPRESTO_A]
@IdFacturaClientePRESTO int output,
@IdCliente int,
@FechaIngreso datetime,
@NumeroFacturaPRESTO varchar(20),
@ImporteTotal numeric(18,2),
@Confirmado varchar(2),
@FechaConfirmacion datetime,
@IdUsuarioConfirmo int
As  
Insert into [FacturasClientesPRESTO]
(
 IdCliente,
 FechaIngreso,
 NumeroFacturaPRESTO,
 ImporteTotal,
 Confirmado,
 FechaConfirmacion,
 IdUsuarioConfirmo
)
Values
(
 @IdCliente,
 @FechaIngreso,
 @NumeroFacturaPRESTO,
 @ImporteTotal,
 @Confirmado,
 @FechaConfirmacion,
 @IdUsuarioConfirmo
)
Select @IdFacturaClientePRESTO=@@identity
Return(@IdFacturaClientePRESTO)





















