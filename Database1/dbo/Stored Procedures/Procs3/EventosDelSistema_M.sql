





























CREATE  Procedure [dbo].[EventosDelSistema_M]
@IdEventoDelSistema int ,
@Descripcion varchar(50),
@Importancia int
AS
Update EventosDelSistema
SET
Descripcion=@Descripcion,
Importancia=@Importancia
where (IdEventoDelSistema=@IdEventoDelSistema)
Return(@IdEventoDelSistema)






























