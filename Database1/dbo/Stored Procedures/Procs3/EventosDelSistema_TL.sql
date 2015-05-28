





























CREATE Procedure [dbo].[EventosDelSistema_TL]
AS 
Select 
IdEventoDelSistema,
Descripcion as Titulo
FROM EventosDelSistema
Order by Descripcion






























