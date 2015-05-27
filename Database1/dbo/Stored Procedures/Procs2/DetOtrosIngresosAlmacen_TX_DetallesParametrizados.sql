
CREATE PROCEDURE [dbo].[DetOtrosIngresosAlmacen_TX_DetallesParametrizados]

@IdOtroIngresoAlmacen int,
@NivelParametrizacion int

AS

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='000011111111133'
	Set @vector_T='00004D109922400'
   END
ELSE
   BEGIN
	Set @vector_X='000011111111133'
	Set @vector_T='00004D103322400'
   END

SELECT
 DetOtr.IdDetalleOtroIngresoAlmacen,
 DetOtr.IdOtroIngresoAlmacen,
 DetOtr.IdArticulo,
 DetOtr.IdUnidad,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetOtr.Partida,
 DetOtr.Cantidad as [Cant.],
 DetOtr.Cantidad1 as [Med.1],
 DetOtr.Cantidad2 as [Med.2],
 Unidades.Descripcion as [En :],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Obras.NumeroObra as [Obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOtrosIngresosAlmacen DetOtr
LEFT OUTER JOIN Articulos ON DetOtr.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetOtr.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Ubicaciones ON DetOtr.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetOtr.IdObra = Obras.IdObra
WHERE (DetOtr.IdOtroIngresoAlmacen = @IdOtroIngresoAlmacen)
