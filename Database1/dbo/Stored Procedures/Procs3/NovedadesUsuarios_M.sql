

CREATE Procedure [dbo].[NovedadesUsuarios_M]
@IdNovedadUsuarios int,
@IdEmpleado int,
@IdEventoDelSistema int,
@FechaEvento datetime,
@Confirmado varchar(2),
@FechaConfirmacion datetime,
@Detalle varchar(200),
@IdEnviadoPor int,
@IdElemento int,
@TipoElemento varchar(50)
As 
Update NovedadesUsuarios
Set 
 IdEmpleado=@IdEmpleado,
 IdEventoDelSistema=@IdEventoDelSistema,
 FechaEvento=@FechaEvento,
 Confirmado=@Confirmado,
 FechaConfirmacion=@FechaConfirmacion,
 Detalle=@Detalle,
 IdEnviadoPor=@IdEnviadoPor,
 IdElemento=@IdElemento,
 TipoElemento=@TipoElemento
Where (IdNovedadUsuarios=@IdNovedadUsuarios)
Return(@IdNovedadUsuarios)

