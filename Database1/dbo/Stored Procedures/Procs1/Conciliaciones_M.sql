CREATE Procedure [dbo].[Conciliaciones_M]

@IdConciliacion int,
@IdCuentaBancaria int,
@Numero varchar(20),
@FechaIngreso datetime,
@SaldoInicialResumen numeric(18,2),
@SaldoFinalResumen numeric(18,2),
@FechaInicial datetime,
@FechaFinal datetime,
@ImporteAjuste numeric(18,2),
@Observaciones ntext,
@IdRealizo int,
@IdAprobo int

AS

UPDATE Conciliaciones
SET
 IdCuentaBancaria=@IdCuentaBancaria,
 Numero=@Numero,
 FechaIngreso=@FechaIngreso,
 SaldoInicialResumen=@SaldoInicialResumen,
 SaldoFinalResumen=@SaldoFinalResumen,
 FechaInicial=@FechaInicial,
 FechaFinal=@FechaFinal,
 ImporteAjuste=@ImporteAjuste,
 Observaciones=@Observaciones,
 IdRealizo=@IdRealizo,
 IdAprobo=@IdAprobo
WHERE (IdConciliacion=@IdConciliacion)

RETURN(@IdConciliacion)