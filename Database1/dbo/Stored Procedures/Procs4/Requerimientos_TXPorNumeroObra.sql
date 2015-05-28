




CREATE  Procedure [dbo].[Requerimientos_TXPorNumeroObra]
@NumeroObra varchar(13)
AS 
SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as Numero,
 Requerimientos.FechaRequerimiento as Fecha,
 Obras.NumeroObra as [Obra]
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
WHERE (not Requerimientos.IdObra is null and Obras.NumeroObra=@NumeroObra)
ORDER BY NumeroRequerimiento




