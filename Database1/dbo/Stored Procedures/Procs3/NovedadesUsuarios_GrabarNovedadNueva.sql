
CREATE Procedure [dbo].[NovedadesUsuarios_GrabarNovedadNueva]

@IdEmpleado int,
@IdEventoDelSistema int,
@Detalle varchar(200),
@IdElemento int = Null,
@TipoElemento varchar(50) = Null,
@IdEnviadoPor int = Null

AS 

IF IsNull(@IdElemento,-1)<>-1
   BEGIN
	IF EXISTS(Select Top 1 IdEmpleado
			From NovedadesUsuarios
			Where IdEmpleado=@IdEmpleado and IsNull(IdElemento,0)=@IdElemento and 
				IsNull(TipoElemento,'')=@TipoElemento and IsNull(Confirmado,'')<>'SI')
		RETURN
   END
ELSE
	SET @IdElemento=Null

INSERT INTO NovedadesUsuarios
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
VALUES
(
 @IdEmpleado,
 @IdEventoDelSistema,
 GetDate(),
 'NO',
 Null,
 @Detalle,
 @IdEnviadoPor,
 @IdElemento,
 @TipoElemento
)
