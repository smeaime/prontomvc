CREATE  Procedure [dbo].[SalidasMateriales_MarcarRecepcionEnDestino]

@IdSalidaMateriales int,
@Funcion int,
@IdUsuario int

AS 

SET NOCOUNT ON

IF @Funcion=0
	UPDATE SalidasMateriales
	SET RecibidosEnDestino='SI', RecibidosEnDestinoFecha=GetDate(), RecibidosEnDestinoIdUsuario=@IdUsuario
	WHERE IdSalidaMateriales=@IdSalidaMateriales
IF @Funcion=1
	UPDATE SalidasMateriales
	SET RecibidosEnDestino='PA', RecibidosEnDestinoFecha=GetDate(), RecibidosEnDestinoIdUsuario=@IdUsuario
	WHERE IdSalidaMateriales=@IdSalidaMateriales
IF @Funcion=2
	UPDATE SalidasMateriales
	SET RecibidosEnDestino=Null, RecibidosEnDestinoFecha=Null, RecibidosEnDestinoIdUsuario=Null
	WHERE IdSalidaMateriales=@IdSalidaMateriales

SET NOCOUNT OFF