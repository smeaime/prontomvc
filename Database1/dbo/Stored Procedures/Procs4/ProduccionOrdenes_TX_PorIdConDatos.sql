CREATE Procedure ProduccionOrdenes_TX_PorIdConDatos
@IdProduccionOrden int
AS 
SELECT  
PO.*,
Colores.Descripcion as Color,
Articulos.Descripcion as ArticuloGenerado,
Articulos.Codigo as CodigoArticuloGenerado,
Unidades.Descripcion as Unidad
FROM ProduccionOrdenes PO
LEFT OUTER JOIN Colores  ON dbo.Colores.IdColor=PO.IdColor
LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=PO.IdArticuloGenerado
LEFT OUTER JOIN Unidades  ON Unidades.IdUnidad=PO.IdUnidad
WHERE (IdProduccionOrden=@IdProduccionOrden)
