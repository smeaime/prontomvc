

CREATE Procedure [dbo].[NovedadesUsuarios_A]
@IdNovedadUsuarios int output,
@IdEmpleado int,
@IdEventoDelSistema int,
@FechaEvento datetime,
@Confirmado varchar(2),
@FechaConfirmacion datetime,
@Detalle varchar(200),
@IdEnviadoPor int,
@IdElemento int,
@TipoElemento varchar(50)
AS 
Insert into NovedadesUsuarios
(
 IdEmpleado,
 IdEventoDelSistema,
 FechaEvento,
 Confirmado,
 FechaConfirmacion,
 Detalle,
 IdEnviadoPor,
 IdElemento,
 TipoElemento
)
Values
(
 @IdEmpleado,
 @IdEventoDelSistema,
 @FechaEvento,
 @Confirmado,
 @FechaConfirmacion,
 @Detalle,
 @IdEnviadoPor,
 @IdElemento,
 @TipoElemento
)
Select @IdNovedadUsuarios=@@identity
Return(@IdNovedadUsuarios)

