






























CREATE PROCEDURE [dbo].[Requerimientos_TXPorObra]
@IdObra int
as
SELECT
Requerimientos.IdRequerimiento,
Requerimientos.NumeroRequerimiento,
Requerimientos.FechaRequerimiento
FROM Requerimientos
WHERE (not Requerimientos.IdObra is null and Requerimientos.IdObra = @IdObra)
GROUP BY Requerimientos.IdRequerimiento,Requerimientos.NumeroRequerimiento,Requerimientos.FechaRequerimiento































