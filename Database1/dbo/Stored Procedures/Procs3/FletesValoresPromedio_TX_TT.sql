CREATE Procedure [dbo].[FletesValoresPromedio_TX_TT]

@IdFleteValorPromedio smallint

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111133'
SET @vector_T='02F222500'

SELECT
 FletesValoresPromedio.IdFleteValorPromedio,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Unidades.Abreviatura as [Un.],
 FletesValoresPromedio.Año as [Año],
 FletesValoresPromedio.Mes as [Mes],
 FletesValoresPromedio.Valor as [Valor promedio],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM FletesValoresPromedio
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=FletesValoresPromedio.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=FletesValoresPromedio.IdUnidad
WHERE (IdFleteValorPromedio=@IdFleteValorPromedio)