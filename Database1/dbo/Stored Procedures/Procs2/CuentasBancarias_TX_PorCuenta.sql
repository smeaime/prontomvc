




CREATE Procedure [dbo].[CuentasBancarias_TX_PorCuenta]
@Cuenta varchar(50)
AS 
SELECT TOP 1 *
FROM CuentasBancarias
WHERE (Cuenta=@Cuenta)





