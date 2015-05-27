CREATE PROCEDURE [dbo].[DetSalidasMateriales_TXSal]

@IdSalidaMateriales int,
@IdObra int = Null

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0000111111111111133'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='0000A0EGF1059902400'
ELSE
	SET @vector_T='000012D991053322400'

SELECT
 DetSal.IdDetalleSalidaMateriales,
 DetSal.IdSalidaMateriales,
 DetSal.IdArticulo,
 DetSal.IdUnidad,
 ValesSalida.NumeroValeSalida as [Vale],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetSal.Talle as [Ta],
 Colores.Descripcion as [Color],
 DetSal.Partida,
 DetSal.Cantidad as [Cant.],
 (Select Sum(Stock.CantidadUnidades) 
	From Stock 
	Left Outer Join Ubicaciones Ubi On Stock.IdUbicacion = Ubi.IdUbicacion
	Left Outer Join Depositos Dep On Ubi.IdDeposito = Dep.IdDeposito
	Where Stock.IdArticulo=DetSal.IdArticulo and (@IdObra=-1 or IsNull(Dep.IdObra,0)=@IdObra)  )  as [Stock tot.actual],
 DetSal.Cantidad1 as [Med.1],
 DetSal.Cantidad2 as [Med.2],
 Unidades.Abreviatura as [En :],
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
LEFT OUTER JOIN Colores ON Colores.IdColor = DetSal.IdColor
WHERE DetSal.IdSalidaMateriales = @IdSalidaMateriales