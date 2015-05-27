































CREATE Procedure [dbo].[Obras_TX_Presupuesto]
@IdObra int,
@IdSector int
AS 
SELECT SUM(HorasPresupuestadas) as [HorasP]
FROM DetallePresupuestosHHObras dhh
WHERE dhh.IdObra=@IdObra and dhh.IdSector=@IdSector and (dhh.EsObra is null or dhh.EsObra='SI')
GROUP BY dhh.IdObra,dhh.IdSector
































