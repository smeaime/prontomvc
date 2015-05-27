CREATE Procedure [dbo].[SalidasMateriales_TX_DetallesResumidos]

@IdSalidaMateriales int

AS 

SELECT 
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Colores.Descripcion as [Color],
 Sum(IsNull(DetSal.Cantidad,0)) as [Cantidad]
FROM DetalleSalidasMateriales DetSal 
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetSal.IdArticulo
LEFT OUTER JOIN Colores ON Colores.IdColor=DetSal.IdColor
WHERE DetSal.IdSalidaMateriales=@IdSalidaMateriales
GROUP BY Articulos.Codigo, Articulos.Descripcion, Colores.Descripcion
ORDER BY Articulos.Codigo, Articulos.Descripcion, Colores.Descripcion