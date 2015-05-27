


CREATE Procedure [dbo].[DistribucionesObras_TL]
AS 
SELECT 
 IdDistribucionObra,
 Descripcion as [Titulo]
FROM DistribucionesObras 
ORDER BY Descripcion


