
CREATE Procedure [dbo].[DetSalidasMaterialesKits_TX_PorIdDetalleSalidaMateriales]

@IdDetalleSalidaMateriales int

AS

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='01111111133'
SET @vector_T='03999E22300'

SELECT 
 Det.IdDetalleSalidaMaterialesKit as [IdDetalleSalidaMaterialesKit],
 Articulos.Codigo as [Codigo],
 Det.IdDetalleSalidaMaterialesKit as [IdAux1],
 Det.IdArticulo as [IdAux2],
 Det.IdUnidad as [IdAux3],
 Articulos.Descripcion as [Material],
 Unidades.Abreviatura as [Un.],
 Det.Cantidad as [Cantidad],
 Det.CostoUnitario as [Costo unitario],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMaterialesKits Det 
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Det.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = Det.IdUnidad
WHERE Det.IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales
