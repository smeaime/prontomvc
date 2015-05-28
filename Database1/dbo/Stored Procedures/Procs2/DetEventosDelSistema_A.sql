





























CREATE Procedure [dbo].[DetEventosDelSistema_A]
@IdDetalleEventoDelSistema int  output,
@IdEventoDelSistema int,
@IdEmpleado int
AS 
Insert into [DetalleEventosDelSistema]
(
 IdEventoDelSistema,
 IdEmpleado
)
Values
(
 @IdEventoDelSistema,
 @IdEmpleado
)
Select @IdDetalleEventoDelSistema=@@identity
Return(@IdDetalleEventoDelSistema)






























