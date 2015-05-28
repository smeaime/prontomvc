


CREATE Procedure [dbo].[EjerciciosContables_TX_PorId]
@IdEjercicioContable int
AS 
SELECT *
FROM EjerciciosContables
WHERE (IdEjercicioContable=@IdEjercicioContable)


