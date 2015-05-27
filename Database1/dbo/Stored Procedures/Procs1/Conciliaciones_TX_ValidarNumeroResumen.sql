


CREATE  Procedure [dbo].[Conciliaciones_TX_ValidarNumeroResumen]

@Numero varchar(20),
@IdCuentaBancaria int

AS 

Declare @IdBanco int
Set @IdBanco=(Select Top 1 CuentasBancarias.IdBanco From CuentasBancarias
		Where CuentasBancarias.IdCuentaBancaria=@IdCuentaBancaria)

SELECT 
 Conciliaciones.IdConciliacion
FROM Conciliaciones
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria
WHERE Conciliaciones.Numero=@Numero and CuentasBancarias.IdBanco=@IdBanco


