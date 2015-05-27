CREATE PROCEDURE [dbo].[DetFacturas_TX_ConDatos]

@IdFactura int,
@IdDetalleFactura int = Null

AS

SET NOCOUNT ON

SET @IdDetalleFactura=IsNull(@IdDetalleFactura,-1)

DECLARE @IdObraDefault int
SET @IdObraDefault=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdObraDefault'),0)

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

SET NOCOUNT OFF

SELECT
 DetFac.*,
 Round((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100)),2) as [Importe],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Caracteristicas],
 IsNull(Articulos.AuxiliarString10,'') as [AuxiliarString10],
 Articulos.CostoPPP as [CostoPPP],
 Unidades.Abreviatura as [Unidad],
 CalidadesClad.Abreviatura as [Calidad],
 (Select Top 1  OrdenesCompra.IdObra
  From DetalleFacturasOrdenesCompra DetFacOC
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
  Left Outer Join OrdenesCompra On doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura) as [IdObra],
 (Select Top 1  Obras.NumeroObra
  From DetalleFacturasOrdenesCompra DetFacOC
  Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
  Left Outer Join OrdenesCompra On doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
  Left Outer Join Obras On OrdenesCompra.IdObra = Obras.IdObra
  Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura) as [Obra],
 (Select Top 1  dr.NumeroCaja
  From DetalleFacturasRemitos DetFacRem
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura) as [NumeroCaja],
 IsNull((Select Top 1  Colores.Descripcion
	 From DetalleFacturasRemitos DetFacRem
	 Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito
	 Left Outer Join UnidadesEmpaque On dr.NumeroCaja = UnidadesEmpaque.NumeroUnidad
	 Left Outer Join DetalleOrdenesCompra doc On dr.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
	 Left Outer Join Colores On IsNull(UnidadesEmpaque.IdColor,doc.IdColor) = Colores.IdColor
	 Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura), 
	(Select Top 1  Colores.Descripcion
	 From DetalleFacturasOrdenesCompra DetFacOC
	 Left Outer Join DetalleOrdenesCompra doc On DetFacOC.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
	 Left Outer Join Colores On doc.IdColor = Colores.IdColor
	 Where DetFacOC.IdDetalleFactura=DetFac.IdDetalleFactura)) as [Color],
 Colores.Descripcion as [Color1],
 (Select Top 1  dr.Partida
  From DetalleFacturasRemitos DetFacRem
  Left Outer Join DetalleRemitos dr On DetFacRem.IdDetalleRemito = dr.IdDetalleRemito
  Where DetFacRem.IdDetalleFactura=DetFac.IdDetalleFactura) as [Partida],
 @IdObraDefault as [IdObraDefault],
 (Select Top 1 Obras.NumeroObra From Obras Where Obras.IdObra=@IdObraDefault) as [ObraDefault],
 Facturas.IdCliente,
 Facturas.IdVendedor,
 Facturas.PorcentajeIva1,
 Facturas.Observaciones as [ObservacionesFactura],
 Facturas.PorcentajeBonificacion
FROM DetalleFacturas DetFac
LEFT OUTER JOIN Facturas ON Facturas.IdFactura = DetFac.IdFactura
LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetFac.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad
LEFT OUTER JOIN #Auxiliar1 ON DetFac.IdDetalleFactura = #Auxiliar1.IdDetalleFactura
LEFT OUTER JOIN #Auxiliar2 ON DetFac.IdDetalleFactura = #Auxiliar2.IdDetalleFactura
LEFT OUTER JOIN Colores ON IsNull(#Auxiliar1.IdColor,IsNull(#Auxiliar2.IdColor,DetFac.IdColor)) = Colores.IdColor
WHERE (@IdFactura=-1 or DetFac.IdFactura = @IdFactura) and (@IdDetalleFactura=-1 or DetFac.IdDetalleFactura=@IdDetalleFactura)
ORDER BY [Obra]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2