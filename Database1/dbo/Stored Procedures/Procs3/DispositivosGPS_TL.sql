
CREATE Procedure [dbo].[DispositivosGPS_TL]

AS 

SELECT 
 IdDispositivoGPS,
 Descripcion as [Titulo]
FROM DispositivosGPS
ORDER BY Descripcion
