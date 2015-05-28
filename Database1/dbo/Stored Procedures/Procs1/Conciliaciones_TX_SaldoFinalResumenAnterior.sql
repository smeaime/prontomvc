
CREATE PROCEDURE [dbo].[Conciliaciones_TX_SaldoFinalResumenAnterior]

@IdCuentaBancaria int

AS

SELECT IsNull((Select Top 1 SaldoFinalResumen From Conciliaciones
		Where Conciliaciones.IdCuentaBancaria=@IdCuentaBancaria
		Order By FechaFinal Desc),0) as [SaldoFinalResumen]
