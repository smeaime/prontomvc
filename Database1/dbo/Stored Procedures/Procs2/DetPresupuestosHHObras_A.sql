





























CREATE Procedure [dbo].[DetPresupuestosHHObras_A]
@IdDetallePresupuestoHHObras int  output,
@IdObra int,
@IdSector int,
@HorasPresupuestadas numeric(12,2),
@IdEquipo int,
@HorasTerceros numeric(12,2),
@PorcentajeAplicado numeric(6,2),
@PorcentajeAplicadoTerceros numeric(6,2),
@EsObra varchar(2)
AS 
Insert into [DetallePresupuestosHHObras]
(
 IdObra,
 IdSector,
 HorasPresupuestadas,
 IdEquipo,
 HorasTerceros,
 PorcentajeAplicado,
 PorcentajeAplicadoTerceros,
 EsObra
)
Values
(
 @IdObra,
 @IdSector,
 @HorasPresupuestadas,
 @IdEquipo,
 @HorasTerceros,
 @PorcentajeAplicado,
 @PorcentajeAplicadoTerceros,
 @EsObra
)
Select @IdDetallePresupuestoHHObras=@@identity
Return(@IdDetallePresupuestoHHObras)






























