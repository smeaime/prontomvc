CREATE Procedure [dbo].[CuentasBancariasSaldos_Actualizar]

@IdCuentaBancaria int,
@Fecha datetime,
@SaldoAnteriorPrimerDiaMes numeric(18,2)

AS 

DECLARE @IdCuentaBancariaSaldo int

SET @IdCuentaBancariaSaldo=IsNull((Select Top 1 IdCuentaBancariaSaldo From CuentasBancariasSaldos Where IdCuentaBancaria=@IdCuentaBancaria and Fecha=@Fecha),0)

IF @IdCuentaBancariaSaldo=0
	INSERT INTO [CuentasBancariasSaldos]
	(IdCuentaBancaria, Fecha, SaldoInicial, SaldoAnteriorPrimerDiaMes)
	VALUES
	(@IdCuentaBancaria, @Fecha, 0, @SaldoAnteriorPrimerDiaMes)
ELSE
	UPDATE CuentasBancariasSaldos
	SET SaldoAnteriorPrimerDiaMes=@SaldoAnteriorPrimerDiaMes
	WHERE IdCuentaBancariaSaldo=@IdCuentaBancariaSaldo