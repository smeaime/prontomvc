





























CREATE Procedure [dbo].[EventosDelSistema_TX_IdEmpleadosPorIdEvento]
@IdEventoDelSistema int
AS 
Select 
DEV.IdDetalleEventoDelSistema,
DEV.IdEmpleado
FROM DetalleEventosDelSistema DEV
LEFT OUTER JOIN EventosDelSistema EV ON DEV.IdEventoDelSistema=EV.IdEventoDelSistema
where (EV.IdEventoDelSistema=@IdEventoDelSistema)






























