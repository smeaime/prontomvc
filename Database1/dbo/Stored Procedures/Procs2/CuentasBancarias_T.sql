﻿
































CREATE Procedure [dbo].[CuentasBancarias_T]
@IdCuentaBancaria int
AS 
SELECT *
FROM CuentasBancarias
WHERE (IdCuentaBancaria=@IdCuentaBancaria)

































