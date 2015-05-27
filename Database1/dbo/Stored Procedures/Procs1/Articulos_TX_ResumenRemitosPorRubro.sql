
CREATE Procedure [dbo].[Articulos_TX_ResumenRemitosPorRubro]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdColor INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT Art.IdArticulo, Det.Cantidad, UnidadesEmpaque.IdColor
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Remitos.IdRemito=Det.IdRemito
 LEFT OUTER JOIN Articulos Art ON Art.IdArticulo=Det.IdArticulo
 LEFT OUTER JOIN UnidadesEmpaque ON Det.NumeroCaja = UnidadesEmpaque.NumeroUnidad
 WHERE (Remitos.FechaRemito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and IsNull(Remitos.Anulado,'NO')<>'SI'

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0001111633'
SET @vector_T='000005C300'

SELECT 
	0 as [IdAux],
	IsNull(Rubros.Descripcion,'') as [K_Rubro],
	0 as [K_Orden],
	IsNull(Rubros.Descripcion,'') as [Rubro],
	IsNull(Subrubros.Descripcion,'') as [Subrubro],
	Art.Codigo as [Codigo],
	Art.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
	#Auxiliar1.Cantidad as [Cantidad],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos Art ON Art.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Rubros ON Art.IdRubro=Rubros.IdRubro
LEFT OUTER JOIN Subrubros ON Art.IdSubrubro=Subrubros.IdSubrubro
LEFT OUTER JOIN Colores ON #Auxiliar1.IdColor = Colores.IdColor

UNION ALL 

SELECT 
	0 as [IdAux],
	IsNull(Rubros.Descripcion,'') as [K_Rubro],
	1 as [K_Orden],
	'TOTAL '+IsNull(Rubros.Descripcion,'') as [Rubro],
	Null as [Subrubro],
	Null as [Codigo],
	Null as [Articulo],
	SUM(#Auxiliar1.Cantidad) as [Cantidad],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos Art ON Art.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Rubros ON Art.IdRubro=Rubros.IdRubro
GROUP BY Art.IdRubro, Rubros.Descripcion

UNION ALL 

SELECT 
	0 as [IdAux],
	IsNull(Rubros.Descripcion,'') as [K_Rubro],
	2 as [K_Orden],
	Null as [Rubro],
	Null as [Subrubro],
	Null as [Codigo],
	Null as [Articulo],
	Null as [Cantidad],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos Art ON Art.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Rubros ON Art.IdRubro=Rubros.IdRubro
GROUP BY Art.IdRubro, Rubros.Descripcion

UNION ALL 

SELECT 
	0 as [IdAux],
	'zzzzzzzzzz' as [K_Rubro],
	3 as [K_Orden],
	'TOTAL GENERAL' as [Rubro],
	Null as [Subrubro],
	Null as [Codigo],
	Null as [Articulo],
	SUM(#Auxiliar1.Cantidad) as [Cantidad],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Rubro],[K_Orden],[Articulo]

DROP TABLE #Auxiliar1
