



CREATE Procedure [dbo].[Tareas_TX_PorId]
@IdTarea int
AS 
SELECT*
FROM Tareas
WHERE (IdTarea=@IdTarea)



