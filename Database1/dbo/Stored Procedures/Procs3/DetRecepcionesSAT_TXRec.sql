
CREATE PROCEDURE [dbo].[DetRecepcionesSAT_TXRec]

@IdRecepcion int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000011111111111111111111133'
SET @vector_T='00002099509919292D055994400'

SELECT
 DetRec.IdDetalleRecepcion,
 DetRec.IdRecepcion,
 DetRec.IdDetallePedido,
 DetRec.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [RM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 Null as [LA],
 Null as [It.LA],
 Obras.NumeroObra as [Obra],
 DetRec.Cantidad as [Cant.],
 DetRec.Cantidad1 as [Med.1],
 DetRec.Cantidad2 as [Med.2],
 Unidades.Abreviatura as  [En],
 (Select Sum(Stock.CantidadUnidades) 
	From Stock 
	Where Stock.IdArticulo=DetRec.IdArticulo)  as [Stock tot.actual],
 DetalleRequerimientos.Cantidad as [Cant.RM],
 Null as [Recibido],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Substring(ControlesCalidad.Descripcion,1,40) as [Control de Calidad],
 DetRec.Partida,
 DetRec.Trasabilidad,
 DetRec.IdArticulo,
 DetRec.IdUnidad,
 DetRec.Observaciones,
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepcionesSAT DetRec
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetRec.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN Unidades ON DetRec.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleRequerimientos ON DetRec.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimientoOriginal
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetRec.IdObra = Obras.IdObra
WHERE (DetRec.IdRecepcion = @IdRecepcion)
