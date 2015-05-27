﻿




CREATE Procedure [dbo].[CtasCtesA_ReimputarComprobante]

@IdCtaCte1 int,
@SaldoPesos1 numeric(18,2),
@SaldoDolar1 numeric(18,2),
@SaldoEuro1 numeric(18,2),
@IdCtaCte2 int,
@SaldoPesos2 numeric(18,2),
@SaldoDolar2 numeric(18,2),
@SaldoEuro2 numeric(18,2)

As

Declare @IdImputacion int
Set @IdImputacion=(Select Top 1 Cta.IdImputacion
			From CuentasCorrientesAcreedores Cta
			Where Cta.IdCtaCte=@IdCtaCte2)

Update CuentasCorrientesAcreedores
Set 
	Saldo=@SaldoPesos1,
	SaldoDolar=@SaldoDolar1,
	SaldoEuro=@SaldoEuro1,
	IdImputacion=@IdImputacion
Where IdCtaCte=@IdCtaCte1

Update CuentasCorrientesAcreedores
Set 
	Saldo=@SaldoPesos2,
	SaldoDolar=@SaldoDolar2, 
	SaldoEuro=@SaldoEuro2
Where IdCtaCte=@IdCtaCte2




