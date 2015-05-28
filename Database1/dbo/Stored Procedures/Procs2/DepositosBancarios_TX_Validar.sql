


CREATE Procedure [dbo].[DepositosBancarios_TX_Validar]
@IdDepositoBancario int,
@IdCuentaBancaria int,
@NumeroDeposito int
AS 
SELECT *
FROM DepositosBancarios
WHERE IdDepositoBancario<>@IdDepositoBancario and 
	IdCuentaBancaria=@IdCuentaBancaria and 
	NumeroDeposito=@NumeroDeposito


