


















CREATE Procedure [dbo].[Valores_BorrarDepositoEfectivo]
@IdTipoValor int,
@NumeroDeposito int,
@IdCuentaBancariaDeposito int,
@FechaDeposito datetime
AS 
DELETE FROM Valores
WHERE IdTipoValor=@IdTipoValor and 
	NumeroDeposito=@NumeroDeposito and 
	IdCuentaBancariaDeposito=@IdCuentaBancariaDeposito and
	FechaDeposito=@FechaDeposito



















