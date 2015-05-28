





























CREATE Procedure [dbo].[EventosDelSistema_T]
@IdEventoDelSistema int
AS 
SELECT *
FROM EventosDelSistema
where (IdEventoDelSistema=@IdEventoDelSistema)






























