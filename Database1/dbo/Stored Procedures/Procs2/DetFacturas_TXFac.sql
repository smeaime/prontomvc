CREATE PROCEDURE [dbo].[DetFacturas_TXFac]

@IdFactura int

AS

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleFactura INTEGER,
			 IdColor INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT DetFac.IdDetalleFactura, Max(IsNull(UnidadesEmpaque.IdColor,0))
 FROM DetalleFacturasRemitos DetFac
 LEFT OUTER JOIN DetalleRemitos det ON DetFac.IdDetalleRemito = det.IdDetalleRemito
 LEFT OUTER JOIN UnidadesEmpaque ON det.NumeroCaja = UnidadesEmpaque.NumeroUnidad
 WHERE DetFac.IdFactura = @IdFactura
 GROUP BY DetFac.IdDetalleFactura

CREATE TABLE #Auxiliar2 
			(
			 IdDetalleFactura INTEGER,
			 IdColor INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT DetFac.IdDetalleFactura, Max(IsNull(det.IdColor,0))
 FROM DetalleFacturasOrdenesCompra DetFac
 LEFT OUTER JOIN DetalleOrdenesCompra det ON DetFac.IdDetalleOrdenCompra = det.IdDetalleOrdenCompra
 WHERE DetFac.IdFactura = @IdFactura
 GROUP BY DetFac.IdDetalleFactura

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00000111111666633'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='000003CGF0011E300'
ELSE
	SET @vector_T='000005D990011E300'

SELECT
 DetFac.IdDetalleFactura,
 DetFac.IdFactura,
 DetFac.NumeroFactura,
 DetFac.IdArticulo,
 DetFac.IdUnidad,
 Articulos.Codigo as [Codigo],
 Case When @SistemaVentasPorTalle='SI' Then Articulos.Descripcion Else Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') End as [Articulo],
 DetFac.Talle as [Ta],
 Colores.Descripcion as [Color],
 DetFac.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 DetFac.Costo,
 DetFac.PrecioUnitario as [Precio U.],
 DetFac.Bonificacion as [Bonif.],
 Round((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100)),2) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFacturas DetFac
LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetFac.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN #Auxiliar1 ON DetFac.IdDetalleFactura = #Auxiliar1.IdDetalleFactura
LEFT OUTER JOIN #Auxiliar2 ON DetFac.IdDetalleFactura = #Auxiliar2.IdDetalleFactura
LEFT OUTER JOIN Colores ON IsNull(#Auxiliar1.IdColor,IsNull(#Auxiliar2.IdColor,DetFac.IdColor)) = Colores.IdColor
WHERE (DetFac.IdFactura = @IdFactura)

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2