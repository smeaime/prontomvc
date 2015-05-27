


CREATE Procedure [dbo].[CtasCtesA_CrearTransaccion]

@IdCtaCte int,
@IdImputacion int

As

Update CuentasCorrientesAcreedores
Set IdImputacion=@IdImputacion
Where IdCtaCte=@IdCtaCte


