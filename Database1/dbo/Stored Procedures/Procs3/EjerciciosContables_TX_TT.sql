





CREATE Procedure [dbo].[EjerciciosContables_TX_TT]
@IdEjercicioContable int
AS 
SELECT 
 IdEjercicioContable,
 NumeroEjercicio as [Numero],
 FechaInicio as [Fecha inicio],
 FechaFinalizacion as [Fecha finalizacion]
FROM EjerciciosContables
WHERE (IdEjercicioContable=@IdEjercicioContable)






