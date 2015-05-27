CREATE Procedure ProduccionFichas_TX_PorIdConDatos
@IdProduccionFicha int
AS 
SELECT  
PO.*,
Colores.Descripcion as Color,
Articulos.Descripcion as ArticuloGenerado,
Articulos.Codigo as CodigoArticuloGenerado,
Unidades.Descripcion as Unidad
FROM ProduccionFichas PO
LEFT OUTER JOIN Colores  ON dbo.Colores.IdColor=PO.IdColor
LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=PO.IdArticuloAsociado
LEFT OUTER JOIN Unidades  ON Unidades.IdUnidad=PO.IdUnidad
WHERE (IdProduccionFicha=@IdProduccionFicha)
