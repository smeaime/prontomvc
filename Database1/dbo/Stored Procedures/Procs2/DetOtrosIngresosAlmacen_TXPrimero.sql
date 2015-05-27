CREATE PROCEDURE [dbo].[DetOtrosIngresosAlmacen_TXPrimero]

@NivelParametrizacion int

AS

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0000111111111111133'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='00004DGF1099E242200'
ELSE
	SET @vector_T='00004D991099E242200'

SELECT TOP 1
 DetOtr.IdDetalleOtroIngresoAlmacen,
 DetOtr.IdOtroIngresoAlmacen,
 DetOtr.IdArticulo,
 DetOtr.IdUnidad,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetOtr.Talle as [Ta],
 Colores.Descripcion as [Color],
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
 DetOtr.CostoUnitario as [Costo],
 Monedas.Abreviatura as [Mon],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOtrosIngresosAlmacen DetOtr
LEFT OUTER JOIN Articulos ON DetOtr.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetOtr.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Ubicaciones ON DetOtr.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetOtr.IdObra = Obras.IdObra
LEFT OUTER JOIN Monedas ON DetOtr.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Colores ON Colores.IdColor = DetOtr.IdColor