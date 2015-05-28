CREATE Procedure [dbo].[Articulos_TX_ResumenVentasPorRubro]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 IdDetalleFactura INTEGER,
			 IdColor INTEGER
			)
INSERT INTO #Auxiliar 
 SELECT DetFac.IdDetalleFactura, Max(IsNull(UnidadesEmpaque.IdColor,0))
 FROM DetalleFacturasRemitos DetFac
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=DetFac.IdFactura
 LEFT OUTER JOIN DetalleRemitos det ON DetFac.IdDetalleRemito = det.IdDetalleRemito
 LEFT OUTER JOIN UnidadesEmpaque ON det.NumeroCaja = UnidadesEmpaque.NumeroUnidad
 WHERE (Fac.FechaFactura between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and IsNull(Fac.Anulada,'NO')<>'SI'
 GROUP BY DetFac.IdDetalleFactura

CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,2),
			 IdColor INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT Art.IdArticulo, 
	DetFac.Cantidad, 
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)<>8  
		Then Round(((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100))) / 
				(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
		Else Round(((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100))) * 
				Fac.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
	End,
	#Auxiliar.IdColor
 FROM DetalleFacturas DetFac 
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=DetFac.IdFactura
 LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=DetFac.IdFactura
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Articulos Art ON Art.IdArticulo=DetFac.IdArticulo
 LEFT OUTER JOIN #Auxiliar ON #Auxiliar.IdDetalleFactura=DetFac.IdDetalleFactura
 WHERE (Fac.FechaFactura between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and IsNull(Fac.Anulada,'NO')<>'SI'

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00011116633'
SET @vector_T='000HH5C1300'

SELECT 
	0 as [IdAux],
	IsNull(Rubros.Descripcion,'') as [K_Rubro],
	0 as [K_Orden],
	IsNull(Rubros.Descripcion,'') as [Rubro],
	IsNull(Subrubros.Descripcion,'') as [Subrubro],
	Art.Codigo as [Codigo],
	Art.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
	#Auxiliar1.Cantidad as [Cantidad],
	#Auxiliar1.Importe as [Importe],
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
	SUM(#Auxiliar1.Importe) as [Importe],
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
	Null as [Importe],
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
	'TOTALES GENERALES' as [Rubro],
	Null as [Subrubro],
	Null as [Codigo],
	Null as [Articulo],
	SUM(#Auxiliar1.Cantidad) as [Cantidad],
	SUM(#Auxiliar1.Importe) as [Importe],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Rubro],[K_Orden],[Articulo]

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1