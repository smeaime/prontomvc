





























CREATE Procedure [dbo].[DetPresupuestosHHObras_M]
@IdDetallePresupuestoHHObras int,
@IdObra int,
@IdSector int,
@HorasPresupuestadas numeric(12,2),
@IdEquipo int,
@HorasTerceros numeric(12,2),
@PorcentajeAplicado numeric(6,2),
@PorcentajeAplicadoTerceros numeric(6,2),
@EsObra varchar(2)
as
Update [DetallePresupuestosHHObras]
SET 
IdObra=@IdObra,
IdSector=@IdSector,
HorasPresupuestadas=@HorasPresupuestadas,
IdEquipo=@IdEquipo,
HorasTerceros=@HorasTerceros,
PorcentajeAplicado=@PorcentajeAplicado,
PorcentajeAplicadoTerceros=@PorcentajeAplicadoTerceros,
EsObra=@EsObra
where (IdDetallePresupuestoHHObras=@IdDetallePresupuestoHHObras)
Return(@IdDetallePresupuestoHHObras)






























