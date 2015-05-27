





























CREATE Procedure [dbo].[DetEventosDelSistema_M]
@IdDetalleEventoDelSistema int,
@IdEventoDelSistema int,
@IdEmpleado int
as
Update [DetalleEventosDelSistema]
SET 
IdEventoDelSistema=@IdEventoDelSistema,
IdEmpleado=@IdEmpleado
where (IdDetalleEventoDelSistema=@IdDetalleEventoDelSistema)
Return(@IdDetalleEventoDelSistema)






























