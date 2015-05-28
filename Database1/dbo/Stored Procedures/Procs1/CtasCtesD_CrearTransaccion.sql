


CREATE Procedure [dbo].[CtasCtesD_CrearTransaccion]

@IdCtaCte int,
@IdImputacion int

As

Update CuentasCorrientesDeudores
Set IdImputacion=@IdImputacion
Where IdCtaCte=@IdCtaCte


