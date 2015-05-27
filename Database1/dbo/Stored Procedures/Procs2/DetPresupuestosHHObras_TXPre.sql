





























CREATE PROCEDURE [dbo].[DetPresupuestosHHObras_TXPre]
@IdObra int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001133'
set @vector_T='0005500'
SELECT 
CASE 
	WHEN  (select top 1 IdDetallePresupuestoHHObras from DetallePresupuestosHHObras DP 
		 where DP.IdSector = Se.IdSector and DP.IdObra = @IdObra ) is null THEN -1
	ELSE    (select top 1 IdDetallePresupuestoHHObras from DetallePresupuestosHHObras DP 
		 where DP.IdSector = Se.IdSector and DP.IdObra = @IdObra ) 
END as [IdDetallePresupuestoHHObras],
@IdObra as [IdObra],
Se.IdSector,
Se.Descripcion as [Sector],
(select top 1 HorasPresupuestadas from DetallePresupuestosHHObras DP
 where DP.IdSector = Se.IdSector and DP.IdObra = @IdObra ) as [Horas],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Sectores Se
WHERE Se.SectorDeObra='SI'






























