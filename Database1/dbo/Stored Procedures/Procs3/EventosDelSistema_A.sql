





























CREATE Procedure [dbo].[EventosDelSistema_A]
@IdEventoDelSistema int  output,
@Descripcion varchar(50),
@Importancia smallint
AS 
Insert into [EventosDelSistema]
(
Descripcion,
Importancia
)
Values
(
@Descripcion,
@Importancia
)
Select @IdEventoDelSistema=@@identity
Return(@IdEventoDelSistema)






























