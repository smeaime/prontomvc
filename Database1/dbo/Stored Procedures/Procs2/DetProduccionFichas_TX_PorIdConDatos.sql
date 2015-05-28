
CREATE PROCEDURE DetProduccionFichas_TX_PorIdConDatos

@IdProduccionFicha  int

AS 


SELECT Det.* ,
Articulos.Codigo as Codigo,
Articulos.Descripcion as Articulo,
Unidades.Descripcion as Unidad,
Colores.Descripcion as Color

FROM dbo.DetalleProduccionFichas Det
LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=Det.IdArticulo
LEFT OUTER JOIN Unidades  ON Unidades.IdUnidad=Det.IdUnidad
LEFT OUTER JOIN Colores  ON Colores.IdColor=Det.IdColor
WHERE (IdProduccionFicha=@IdProduccionFicha)
