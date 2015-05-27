CREATE Procedure [dbo].[Conciliaciones_A]

@IdConciliacion int  output,
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

INSERT INTO Conciliaciones
(
 IdCuentaBancaria,
 Numero,
 FechaIngreso,
 SaldoInicialResumen,
 SaldoFinalResumen,
 FechaInicial,
 FechaFinal,
 ImporteAjuste,
 Observaciones,
 IdRealizo,
 IdAprobo
)
VALUES
(
 @IdCuentaBancaria,
 @Numero,
 @FechaIngreso,
 @SaldoInicialResumen,
 @SaldoFinalResumen,
 @FechaInicial,
 @FechaFinal,
 @ImporteAjuste,
 @Observaciones,
 @IdRealizo,
 @IdAprobo
)

SELECT @IdConciliacion=@@identity

RETURN(@IdConciliacion)