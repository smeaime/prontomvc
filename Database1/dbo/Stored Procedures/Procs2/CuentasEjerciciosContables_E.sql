


CREATE Procedure [dbo].[CuentasEjerciciosContables_E]
@IdCuentaEjercicioContable int  
As 
Delete CuentasEjerciciosContables
Where (IdCuentaEjercicioContable=@IdCuentaEjercicioContable)


