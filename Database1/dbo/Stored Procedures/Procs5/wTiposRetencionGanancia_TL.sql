
CREATE Procedure [dbo].[wTiposRetencionGanancia_TL]
AS 
SELECT IdTipoRetencionGanancia, Descripcion as [Titulo]
FROM TiposRetencionGanancia 
ORDER BY Descripcion

