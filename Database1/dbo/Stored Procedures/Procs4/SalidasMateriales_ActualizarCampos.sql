CREATE Procedure [dbo].[SalidasMateriales_ActualizarCampos]

@IdSalidaMateriales int,
@Detalle varchar(30)

AS

UPDATE SalidasMateriales
SET 
 Detalle=@Detalle
WHERE IdSalidaMateriales=@IdSalidaMateriales

