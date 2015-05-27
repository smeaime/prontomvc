


CREATE Procedure [dbo].[Cuentas_T]
@IdCuenta int
AS 
SELECT *
FROM Cuentas
WHERE (IdCuenta=@IdCuenta)


