



CREATE Procedure [dbo].[Tareas_TX_PorTipo]
@TipoTarea int
AS 
SELECT *
FROM Tareas
WHERE TipoTarea=@TipoTarea
ORDER BY Descripcion



