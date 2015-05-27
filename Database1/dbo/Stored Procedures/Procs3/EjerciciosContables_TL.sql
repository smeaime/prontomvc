


CREATE Procedure [dbo].[EjerciciosContables_TL]
AS 
SELECT 
 IdEjercicioContable,
 Convert(varchar,NumeroEjercicio)+
	' del '+Convert(varchar,FechaInicio,103)+
	' al '+Convert(varchar,FechaFinalizacion,103) as [Titulo]
FROM EjerciciosContables
ORDER BY NumeroEjercicio


