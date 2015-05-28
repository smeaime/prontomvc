CREATE Procedure [dbo].[CuentasEjerciciosContables_TX_PorCuentaEjercicio]

@IdCuenta int,
@IdEjercicioContable int

AS 

SELECT TOP 1 *
FROM CuentasEjerciciosContables
WHERE IdCuenta=@IdCuenta and IdEjercicioContable=@IdEjercicioContable