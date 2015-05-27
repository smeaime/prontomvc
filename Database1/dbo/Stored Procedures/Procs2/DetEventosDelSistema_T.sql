





























CREATE Procedure [dbo].[DetEventosDelSistema_T]
@IdDetalleEventoDelSistema int
AS 
SELECT *
FROM [DetalleEventosDelSistema]
where (IdDetalleEventoDelSistema=@IdDetalleEventoDelSistema)






























