CREATE Procedure [dbo].[CuentasEjerciciosContables_T]

@IdCuentaEjercicioContable int

AS 

SELECT *
FROM CuentasEjerciciosContables
WHERE (IdCuentaEjercicioContable=@IdCuentaEjercicioContable)