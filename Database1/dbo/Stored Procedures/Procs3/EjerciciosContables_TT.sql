


CREATE Procedure [dbo].[EjerciciosContables_TT]
AS 
SELECT 
 IdEjercicioContable,
 NumeroEjercicio as [Numero],
 FechaInicio as [Fecha inicio],
 FechaFinalizacion as [Fecha finalizacion]
FROM EjerciciosContables
ORDER BY NumeroEjercicio


