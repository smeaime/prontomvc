





























CREATE Procedure [dbo].[DetPresupuestosHHObrasPorMes_A]
@IdDetallePresupuestoHHObrasPorMes int  output,
@IdObra int,
@IdSector int,
@Año int,
@Mes int,
@HorasProgramadas numeric(18,2)
AS 
Insert into [DetallePresupuestosHHObrasPorMes]
(
 IdObra,
 IdSector,
 Año,
 Mes,
 HorasProgramadas
)
Values
(
 @IdObra,
 @IdSector,
 @Año,
 @Mes,
 @HorasProgramadas
)
Select @IdDetallePresupuestoHHObrasPorMes=@@identity
Return(@IdDetallePresupuestoHHObrasPorMes)






























