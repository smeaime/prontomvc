
CREATE Procedure [dbo].[TiposEquipo_TL]
AS 
SELECT IdTipoEquipo, Descripcion as [Titulo]
FROM TiposEquipo
ORDER BY Descripcion
