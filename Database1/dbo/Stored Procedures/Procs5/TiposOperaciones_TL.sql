


CREATE Procedure [dbo].[TiposOperaciones_TL]

AS 

SELECT IdTipoOperacion, Descripcion as [Titulo]
FROM TiposOperaciones 
ORDER BY Descripcion
