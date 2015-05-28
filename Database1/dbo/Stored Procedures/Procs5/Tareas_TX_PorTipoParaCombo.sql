



CREATE Procedure [dbo].[Tareas_TX_PorTipoParaCombo]
@TipoTarea int
AS 
SELECT
 IdTarea,
 Descripcion as Titulo
FROM Tareas 
WHERE TipoTarea=@TipoTarea
ORDER BY Descripcion



