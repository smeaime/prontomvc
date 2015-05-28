



CREATE Procedure [dbo].[Tareas_TL]
AS 
SELECT
 IdTarea,
 Descripcion as Titulo
FROM Tareas 
ORDER BY Descripcion



