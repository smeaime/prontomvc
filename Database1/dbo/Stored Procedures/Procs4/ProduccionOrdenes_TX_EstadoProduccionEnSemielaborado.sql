
CREATE PROCEDURE [ProduccionOrdenes_TX_EstadoProduccionEnSemielaborado]

@IdProduccionOrden int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='00001111111101111133'
SET @vector_T='00001EE111110EDD9900'


SELECT
 DET.IdDetalleProduccionOrden,
 DET.IdProduccionOrden,
 DET.IdArticulo,
 DET.IdUnidad,
 Articulos.Codigo as [Codigo],

 Articulos.Descripcion as Articulo,
 Colores.Descripcion AS [Color],
 DET.Partida,
 DET.Cantidad as [Cant.],
 isnull(dbo.fProduccionAvanzadoMaterial(DET.IdProduccionOrden,DET.IdArticulo,det.idcolor),0) as [Avance],

 Articulos.CostoReposicion,
 isnull(dbo.fProduccionAvanzadoMaterial(DET.IdProduccionOrden,DET.IdArticulo,det.idcolor),0) * Articulos.CostoReposicion as Total,
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=DET.IdArticulo)  as [Stock tot.actual],
 isnull(Unidades.Descripcion,'') as [En :],
 isnull (Depositos.Descripcion+' - E:'+Ubicaciones.Estanteria+' M:'+Ubicaciones.Modulo+' G:'+Ubicaciones.Gabeta,'') as [Ubicacion],

 isnull(CAB.Descripcion,'') as [Proceso Asociado],
 CAB.idproduccionproceso,
 DET.tolerancia as Tolerancia,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X

FROM DetalleProduccionOrdenes DET
LEFT OUTER JOIN Articulos ON DET.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DET.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON DET.IdColor = Colores.IdColor
LEFT OUTER JOIN Ubicaciones ON DET.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DET.IdObra = Obras.IdObra
LEFT OUTER JOIN ProduccionProcesos CAB ON CAB.IdProduccionProceso=DET.IdProduccionProceso
WHERE (DET.IdProduccionOrden = @IdProduccionOrden)


UNION ALL

SELECT
 null as IdDetalleProduccionOrden,
 null as IdProduccionOrden,
 null as IdArticulo,
 null as IdUnidad,
 'zzz TOTAL zzz' as [Codigo],

 'TOTAL' as Articulo,
 null AS [Color],
 null as Partida,
 null as [Cant.],
 null as [Avance],

 null as CostoReposicion,
 sum (isnull(dbo.fProduccionAvanzadoMaterial(DET.IdProduccionOrden,DET.IdArticulo,det.idcolor),0) * Articulos.CostoReposicion) as Total,
 null  as [Stock tot.actual],
 null  as [En :],
 null  as [Ubicacion],

 null as [Proceso Asociado],
 null as idproduccionproceso,
 null as Tolerancia,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X

FROM DetalleProduccionOrdenes DET
LEFT OUTER JOIN Articulos ON DET.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DET.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON DET.IdColor = Colores.IdColor
LEFT OUTER JOIN Ubicaciones ON DET.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DET.IdObra = Obras.IdObra
LEFT OUTER JOIN ProduccionProcesos CAB ON CAB.IdProduccionProceso=DET.IdProduccionProceso
WHERE (DET.IdProduccionOrden = @IdProduccionOrden)

ORDER BY Codigo

