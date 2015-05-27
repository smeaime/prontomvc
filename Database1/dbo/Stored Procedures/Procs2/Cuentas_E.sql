
CREATE Procedure [dbo].[Cuentas_E]

@IdCuenta int  

AS 

DELETE DetalleCuentas
WHERE (IdCuenta=@IdCuenta)

DELETE Cuentas
WHERE (IdCuenta=@IdCuenta)
