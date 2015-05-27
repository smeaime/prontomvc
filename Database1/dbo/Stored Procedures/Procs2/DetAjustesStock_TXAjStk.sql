CREATE PROCEDURE [dbo].[DetAjustesStock_TXAjStk]

@IdAjusteStock int

AS

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)

SET @vector_X='00011111111111111133'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='00029DGF233399106500'
ELSE
	SET @vector_T='00039D99233300106500'

SELECT
 DetAju.IdDetalleAjusteStock,
 DetAju.IdAjusteStock,
 DetAju.IdArticulo,
 Articulos.Codigo as [Codigo],
 DetAju.IdDetalleAjusteStock as [IdAux1],
 Articulos.Descripcion+IsNull(' '+C1.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 DetAju.Talle as [Ta],
 C2.Descripcion as [Color],
 DetAju.Partida,
 DetAju.CantidadUnidades as [Cantidad],
 DetAju.CantidadInventariada as [Cant.Inv.],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=DetAju.IdArticulo)  as [Stock tot.actual],
 DetAju.Cantidad1 as [Med.1],
 DetAju.Cantidad2 as [Med.2],
 Unidades.Abreviatura as [En :],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Obras.NumeroObra as [Obra],
 DetAju.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAjustesStock DetAju
LEFT OUTER JOIN Articulos ON DetAju.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetAju.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Ubicaciones ON DetAju.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetAju.IdObra = Obras.IdObra
LEFT OUTER JOIN UnidadesEmpaque ON DetAju.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Colores C1 ON C1.IdColor = UnidadesEmpaque.IdColor
LEFT OUTER JOIN Colores C2 ON C2.IdColor = DetAju.IdColor
WHERE (DetAju.IdAjusteStock = @IdAjusteStock)