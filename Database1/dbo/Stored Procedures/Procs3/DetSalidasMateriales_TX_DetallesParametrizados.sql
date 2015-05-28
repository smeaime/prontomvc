
CREATE PROCEDURE [dbo].[DetSalidasMateriales_TX_DetallesParametrizados]

@IdSalidaMateriales int,
@NivelParametrizacion int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='00001111111111133'
	Set @vector_T='000012D1059922400'
   END
ELSE
   BEGIN
	Set @vector_X='00001111111111133'
	Set @vector_T='000012D1053322400'
   END

SELECT
 DetSal.IdDetalleSalidaMateriales,
 DetSal.IdSalidaMateriales,
 DetSal.IdArticulo,
 DetSal.IdUnidad,
 ValesSalida.NumeroValeSalida as [Vale],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetSal.Partida,
 DetSal.Cantidad as [Cant.],
 (Select Sum(Stock.CantidadUnidades) 
  From Stock Where Stock.IdArticulo=DetSal.IdArticulo)  as [Stock tot.actual],
 DetSal.Cantidad1 as [Med.1],
 DetSal.Cantidad2 as [Med.2],
 Unidades.Descripcion as [En :],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Obras.NumeroObra as [Obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN ValesSalida ON DetalleValesSalida.IdValeSalida = ValesSalida.IdValeSalida
LEFT OUTER JOIN Ubicaciones ON DetSal.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetSal.IdObra = Obras.IdObra
WHERE (DetSal.IdSalidaMateriales = @IdSalidaMateriales)
