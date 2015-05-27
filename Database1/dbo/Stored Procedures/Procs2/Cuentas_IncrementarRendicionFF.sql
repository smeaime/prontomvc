
CREATE Procedure [dbo].[Cuentas_IncrementarRendicionFF]

@IdCuentaFF int,
@NumeroAuxiliar int

AS 

UPDATE Cuentas
SET NumeroAuxiliar=@NumeroAuxiliar
WHERE IdCuenta=@IdCuentaFF
