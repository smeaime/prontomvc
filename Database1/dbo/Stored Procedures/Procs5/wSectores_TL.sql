
CREATE PROCEDURE [dbo].[wSectores_TL]
AS 
SELECT IdSector, Descripcion as [Titulo]
FROM Sectores
ORDER BY Descripcion

