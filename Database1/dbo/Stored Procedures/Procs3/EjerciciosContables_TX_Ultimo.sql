




CREATE Procedure [dbo].[EjerciciosContables_TX_Ultimo]
AS
SELECT TOP 1 *
FROM EjerciciosContables
ORDER BY FechaFinalizacion DESC





