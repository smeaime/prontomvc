CREATE PROCEDURE [dbo].[DetConjuntos_TXConj]

@IdConjunto int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00011111188881188133'
SET @vector_T='0004D222122239944900'

SELECT
 DetCj.IdDetalleConjunto,
 DetCj.IdConjunto,
 DetCj.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Componente],
 DetCj.Cantidad as [Cantidad],
 DetCj.Cantidad1 as [Med.1],
 DetCj.Cantidad2 as [Med.2],
 Unidades.Abreviatura as [En :],
 Articulos.CostoPPP as [Costo PPP],
 DetCj.Cantidad * Articulos.CostoPPP as [Importe PPP],
 Articulos.CostoReposicion as [Costo Rep.],
 DetCj.Cantidad * Articulos.CostoReposicion as [Importe Rep.], 
 DetCj.Cantidad * Articulos.CostoPPP as [ImportePPP1],
 DetCj.Cantidad * Articulos.CostoReposicion as [ImporteReposicion1], 
 Articulos.CostoReposicionDolar as [Costo Rep.u$s],
 DetCj.Cantidad * Articulos.CostoReposicionDolar as [Importe Rep.u$s], 
 DetCj.Cantidad * Articulos.CostoReposicionDolar as [ImporteReposicionu$s1], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleConjuntos DetCj
LEFT OUTER JOIN Articulos ON DetCj.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetCj.IdUnidad = Unidades.IdUnidad
WHERE (DetCj.IdConjunto = @IdConjunto)