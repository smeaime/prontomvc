





























CREATE PROCEDURE [dbo].[DetPresupuestosHHObras_TXPrimero]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001133'
set @vector_T='0005500'
SELECT TOP 1
DetPre.IdDetallePresupuestoHHObras,
DetPre.IdObra,
DetPre.IdSector,
Sectores.Descripcion as [Sector],
DetPre.HorasPresupuestadas as [Horas],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetallePresupuestosHHObras DetPre
LEFT OUTER JOIN Sectores ON DetPre.IdSector = Sectores.IdSector






























