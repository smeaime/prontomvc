
CREATE Procedure [dbo].[DetSalidasMaterialesKits_A]

@IdDetalleSalidaMaterialesKit int  output,
@IdDetalleSalidaMateriales int,
@IdArticulo int,
@IdUnidad int,
@Cantidad numeric(18,2),
@CostoUnitario numeric(18,4)

AS 

INSERT INTO [DetalleSalidasMaterialesKits]
(
 IdDetalleSalidaMateriales,
 IdArticulo,
 IdUnidad,
 Cantidad,
 CostoUnitario
)
VALUES 
(
 @IdDetalleSalidaMateriales,
 @IdArticulo,
 @IdUnidad,
 @Cantidad,
 @CostoUnitario
)

SELECT @IdDetalleSalidaMaterialesKit=@@identity

RETURN(@IdDetalleSalidaMaterialesKit)
