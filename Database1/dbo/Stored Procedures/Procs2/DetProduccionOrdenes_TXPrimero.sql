
CREATE PROCEDURE DetProduccionOrdenes_TXPrimero

@NivelParametrizacion int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='000011111110011110133'
SET @vector_T='0000D1DEC1100EDD10100'

SELECT TOP 1
 DetSal.IdDetalleProduccionOrden,
 DetSal.IdProduccionOrden,
 DetSal.IdArticulo,
 DetSal.IdUnidad,
 '    ' as [*],
 
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as Articulo,
 Colores.Descripcion AS [Color],
--DetSal.Partida,
rtrim(dbo.fProduccionPartidaParte(Detsal.IdProduccionOrden,Detsal.IdArticulo,detsal.idcolor)) as Partida, 
 DetSal.Cantidad as [Cant.],


 dbo.fProduccionAvanzadoMaterial(Detsal.IdProduccionOrden,Detsal.IdArticulo, Detsal.idcolor) as [Avance],
 (Select Sum(Stock.CantidadUnidades)  From Stock Where Stock.IdArticulo=DetSal.IdArticulo)  as [Stock tot.actual],
 DetSal.Cantidad1 as [Med.1],
 ' ' as [% del Total],
 Unidades.Descripcion as [En :],


rtrim(dbo.fProduccionUbicacionParte(Detsal.IdProduccionOrden,Detsal.IdArticulo)) as [Ubicacion],
rtrim(ProduccionProcesos.Descripcion) as [Proceso Asociado],
 ProduccionProcesos.idproduccionproceso,
 detsal.tolerancia as Tolerancia,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionOrdenes DetSal
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON DetSal.IdColor = Colores.IdColor
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN ValesSalida ON DetalleValesSalida.IdValeSalida = ValesSalida.IdValeSalida
LEFT OUTER JOIN Ubicaciones ON DetSal.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetSal.IdObra = Obras.IdObra
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=DetSal.IdProduccionProceso



