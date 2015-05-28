
CREATE Procedure [dbo].[DetSalidasMaterialesKits_M]

@IdDetalleSalidaMaterialesKit int,
@IdDetalleSalidaMateriales int,
@IdArticulo int,
@IdUnidad int,
@Cantidad numeric(18,2),
@CostoUnitario numeric(18,4)

AS

UPDATE [DetalleSalidasMaterialesKits]
SET 
 IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales,
 IdArticulo=@IdArticulo,
 IdUnidad=@IdUnidad,
 Cantidad=@Cantidad,
 CostoUnitario=@CostoUnitario
WHERE (IdDetalleSalidaMaterialesKit=@IdDetalleSalidaMaterialesKit)

RETURN(@IdDetalleSalidaMaterialesKit)
