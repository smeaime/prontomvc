





























CREATE Procedure [dbo].[DetPresupuestosHHObrasPorMes_M]
@IdDetallePresupuestoHHObrasPorMes int,
@IdObra int,
@IdSector int,
@Año int,
@Mes int,
@HorasProgramadas numeric(18,2)
as
Update [DetallePresupuestosHHObrasPorMes]
Set 
 IdObra=@IdObra,
 IdSector=@IdSector,
 Año=@Año,
 Mes=@Mes,
 HorasProgramadas=@HorasProgramadas
Where (IdDetallePresupuestoHHObrasPorMes=@IdDetallePresupuestoHHObrasPorMes)
Return(@IdDetallePresupuestoHHObrasPorMes)






























