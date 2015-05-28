CREATE Procedure DetProduccionOrdenes_TX_PorIdOrdenParaCombo
 @IdProduccionOrden int 
AS 
SELECT distinct
 det.IdArticulo,
 Articulos.Descripcion as Titulo,
 DETFICHA.IdDetalleProduccionFicha
FROM DetalleProduccionOrdenes det
LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=Det.IdArticulo

INNER JOIN dbo.ProduccionOrdenes CABOP ON det.IdProduccionOrden=cabop.IdProduccionOrden
LEFT OUTER JOIN dbo.ProduccionFichas FICHA ON cabop.IdArticuloGenerado=FICHA.IdArticuloAsociado
LEFT OUTER JOIN dbo.DetalleProduccionFichas DETFICHA ON FICHA.IdProduccionFicha=DETFICHA.idproduccionficha AND DETFICHA.IdArticulo=det.IdArticulo
--parche (mientras no tenga el orden de renglon) para ordenar segun la ficha original
WHERE det.IdProduccionOrden=@IdProduccionOrden
ORDER by DETFICHA.IdDetalleProduccionFicha, det.idarticulo
