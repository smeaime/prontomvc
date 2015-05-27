CREATE Procedure [dbo].[PresupuestoObrasNodos_Inicializar]

AS 

INSERT INTO [PresupuestoObrasNodos]
SELECT Null, 0, '/', 1, Obras.IdObra, Null, Null, Null, Obras.NumeroObra, '%', 7, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null
FROM Obras
WHERE Obras.Activa='SI' and not Exists(Select Top 1 pon.IdObra From PresupuestoObrasNodos pon Where pon.IdObra=Obras.IdObra)