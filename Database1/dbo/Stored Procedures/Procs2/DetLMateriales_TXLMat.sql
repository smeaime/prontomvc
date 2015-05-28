

CREATE PROCEDURE [dbo].[DetLMateriales_TXLMat]

@IdLMateriales int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0011111111111111000000133'
SET @vector_T='0000290221213333000000500'

SELECT
 DetLMat.IdDetalleLMateriales,
 DetLMat.IdLMateriales,
 DetLMat.NumeroItem as [Conj.],
 DetLMat.NumeroOrden as [Pos.],
 DetLMat.Revision as [Rev.],
 DetalleAcopios.NumeroItem as [I.Aco.],
 DetLMat.Cantidad as [Cant.],
 DetLMat.Cantidad1 as [Med.1],
 DetLMat.Cantidad2 as [Med.2],
 Unidades.Abreviatura as [Un.],
 Articulos.Codigo as [Codigo],
 CASE 
	WHEN DetLMat.IdArticulo IS NULL and DetLMat.Detalle IS NOT NULL  THEN DetLMat.Detalle
	WHEN DetLMat.IdArticulo IS NULL and DetLMat.NumeroOrden=0 THEN DetLMat.DescripcionManual
	WHEN DetLMat.IdArticulo IS NULL and DetLMat.NumeroOrden<>0 THEN '     '+DetLMat.DescripcionManual
	WHEN DetLMat.IdArticulo IS NOT NULL and DetLMat.NumeroOrden=0 THEN Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS
	WHEN DetLMat.IdArticulo IS NOT NULL and DetLMat.NumeroOrden<>0 THEN '     '+Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS
	ELSE NULL
 END as [Articulo],
 Articulos.CostoPPP as [Costo PPP],
 DetLMat.Cantidad * Articulos.CostoPPP as [Importe PPP],
 Articulos.CostoReposicion as [Costo Rep.],
 DetLMat.Cantidad * Articulos.CostoReposicion as [Importe Rep.],
 DetLMat.Peso,
 (SELECT Unidades.Descripcion
	FROM Unidades
	WHERE Unidades.IdUnidad=DetLMat.IdUnidadPeso) as  [Unidad 2 en],
 ControlesCalidad.Descripcion as [Control de Calidad],
 DetLMat.Observaciones,
 DetLMat.Adjunto,
 DetLMat.ArchivoAdjunto,
 DetalleObrasDestinos.Destino as [Destino],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN Articulos ON DetLMat.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetLMat.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN ControlesCalidad ON DetLMat.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetalleAcopios ON DetLMat.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN DetalleObrasDestinos ON DetLMat.IdDetalleObraDestino = DetalleObrasDestinos.IdDetalleObraDestino
WHERE (DetLMat.IdLMateriales = @IdLMateriales)
ORDER by DetLMat.NumeroItem,DetLMat.NumeroOrden
