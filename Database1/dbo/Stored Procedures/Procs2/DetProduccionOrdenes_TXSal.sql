


--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////


create PROCEDURE [dbo].[DetProduccionOrdenes_TXSal]

@IdProduccionOrden int,
@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0000111111111111133'
SET @vector_T='000011E110111111100'
SELECT
 DetSal.IdDetalleProduccionOrden,
 DetSal.IdProduccionOrden,
 DetSal.IdArticulo,
 DetSal.IdUnidad,
-- ValesSalida.NumeroValeSalida as [Vale],
 '    ' as [Estado],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as Articulo,
 DetSal.Partida,
 DetSal.Cantidad as [Cant.],
dbo.fProduccionAvanzadoMaterial(Detsal.IdProduccionOrden,Detsal.IdArticulo,Detsal.IdColor) as [Avance],
 (Select Sum(Stock.CantidadUnidades) 
  From Stock Where Stock.IdArticulo=DetSal.IdArticulo)  as [Stock tot.actual],
 DetSal.Cantidad1 as [Med.1],
 ' ' as [%],
-- DetSal.Cantidad2 as [Med.2],
 Unidades.Descripcion as [En :],
 Depositos.Descripcion+' - E:'+Ubicaciones.Estanteria+
	' M:'+Ubicaciones.Modulo+' G:'+Ubicaciones.Gabeta as [Ubicacion],
ProduccionProcesos.Descripcion as [Proceso Asociado],
 Obras.NumeroObra as [Obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionOrdenes DetSal
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN ValesSalida ON DetalleValesSalida.IdValeSalida = ValesSalida.IdValeSalida
LEFT OUTER JOIN Ubicaciones ON DetSal.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetSal.IdObra = Obras.IdObra
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=DetSal.IdProduccionProceso
WHERE DetSal.IdProduccionOrden = @IdProduccionOrden


