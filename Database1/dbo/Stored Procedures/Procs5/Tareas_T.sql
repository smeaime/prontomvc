



CREATE Procedure [dbo].[Tareas_T]
@IdTarea int
AS 
SELECT*
FROM Tareas
WHERE (IdTarea=@IdTarea)



