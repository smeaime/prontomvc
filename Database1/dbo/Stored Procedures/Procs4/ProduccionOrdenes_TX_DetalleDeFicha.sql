
CREATE PROCEDURE ProduccionOrdenes_TX_DetalleDeFicha
@IdProduccionFicha int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='000011111110011110133'
SET @vector_T='0000D1DEC1100EDD10100'

SELECT
 null as IdDetalleProduccionOrden,
 null as IdProduccionOrden,
 DetSal.IdArticulo,
 DetSal.IdUnidad,
 '    ' as [*],

 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as Articulo,
 Colores.Descripcion AS [Color],
 null as Partida,
 DetSal.Cantidad as [Cant.],

 ''  as [Avance],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=DetSal.IdArticulo)  as [Stock tot.actual],
 detsal.idcolor,  --no sabía cómo pasarselo para no romper la coherencia del encabezado.  
--'' as [Med.1],
 ' ' as [% del Total],
 Unidades.Descripcion as [En :],

 ''  as [Ubicacion],
 ProduccionProcesos.Descripcion as [Proceso Asociado],
 ProduccionProcesos.idproduccionproceso,
 detsal.tolerancia as Tolerancia,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionFichas DetSal --DetalleProduccionOrdenes DetSal
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON DetSal.IdColor = Colores.IdColor
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=DetSal.IdProduccionProceso
WHERE (DetSal.IdProduccionFicha = @IdProduccionFicha)
ORDER  BY DetSal.IddetalleProduccionFicha

