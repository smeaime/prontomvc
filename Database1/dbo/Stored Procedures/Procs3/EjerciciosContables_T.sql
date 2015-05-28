


CREATE Procedure [dbo].[EjerciciosContables_T]
@IdEjercicioContable int
AS 
SELECT *
FROM EjerciciosContables
WHERE (IdEjercicioContable=@IdEjercicioContable)


