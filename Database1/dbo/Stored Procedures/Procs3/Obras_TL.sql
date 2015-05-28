
CREATE Procedure [dbo].[Obras_TL]

AS 

SELECT IdObra, NumeroObra as Titulo
FROM Obras
WHERE IsNull(Obras.Activa,'')<>'NO' and Obras.Jerarquia is not null
ORDER BY NumeroObra
