
CREATE Procedure [dbo].[wObras_TL]

AS 

SELECT IdObra
--,NumeroObra as [Titulo]  --version original
,NumeroObra + ' - ' + Descripcion as [Titulo] --version mariano 

FROM Obras
WHERE Obras.FechaFinalizacion is null and Obras.Jerarquia is not null
ORDER BY NumeroObra

