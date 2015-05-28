































CREATE Procedure [dbo].[Obras_TX_Presupuesto_OT]
@IdOT int,
@IdSector int
AS 
SELECT SUM(HorasPresupuestadas) as [HorasP]
FROM DetallePresupuestosHHObras dhh
WHERE dhh.IdObra=@IdOT and dhh.IdSector=@IdSector and dhh.EsObra='NO'
GROUP BY dhh.IdObra,dhh.IdSector
































