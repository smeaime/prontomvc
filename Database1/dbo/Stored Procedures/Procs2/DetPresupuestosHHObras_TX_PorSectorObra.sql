





























CREATE PROCEDURE [dbo].[DetPresupuestosHHObras_TX_PorSectorObra]
@IdObra int
as
SELECT
dp.IdObra,
dp.IdSector,
SUM(dp.HorasPresupuestadas) as [HorasP],
SUM(dp.HorasTerceros) as [HorasT]
FROM DetallePresupuestosHHObras dp
WHERE ( (@IdObra<100000 and dp.IdObra=@IdObra and (dp.EsObra is null or dp.EsObra='SI')) or
	(@IdObra>100000 and dp.IdObra=@IdObra-100000 and dp.EsObra='NO') ) and 
	(dp.IdEquipo is null or 
	 Exists(Select IdEquipo From Equipos Where dp.IdEquipo=Equipos.IdEquipo))
GROUP BY dp.IdObra,dp.IdSector






























