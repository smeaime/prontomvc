CREATE PROCEDURE [dbo].[DetFacturas_TX_ConDatosAgrupados]

@IdFactura int,
@TomarColores varchar(2) = Null,
@ConObservacionesDetalle varchar(2) = Null

AS

SET NOCOUNT ON

SET @TomarColores=IsNull(@TomarColores,'SI')
SET @ConObservacionesDetalle=IsNull(@ConObservacionesDetalle,'NO')

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleFactura INTEGER,
			 IdColor INTEGER
			)
IF @TomarColores='SI'
  BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT DetFac.IdDetalleFactura, Max(IsNull(UnidadesEmpaque.IdColor,IsNull(dr.IdColor,0)))
	 FROM DetalleFacturasRemitos DetFac
	 LEFT OUTER JOIN DetalleRemitos dr ON DetFac.IdDetalleRemito = dr.IdDetalleRemito
	 LEFT OUTER JOIN UnidadesEmpaque ON dr.NumeroCaja = UnidadesEmpaque.NumeroUnidad
	 WHERE DetFac.IdFactura = @IdFactura
	 GROUP BY DetFac.IdDetalleFactura
  END

SET NOCOUNT OFF

IF @ConObservacionesDetalle='SI'
	SELECT
	 DetFac.IdArticulo,
	 DetFac.PrecioUnitario,
	 DetFac.Bonificacion,
	 Sum(IsNull(DetFac.Cantidad,0)) as [Cantidad],
	 DetFac.PrecioUnitario,
	 Sum(Round((IsNull(DetFac.Cantidad,0)*IsNull(DetFac.PrecioUnitario,0))*(1-(IsNull(DetFac.Bonificacion,0)/100)),2)) as [Importe],
	 DetFac.OrigenDescripcion,
	 Convert(varchar(1000),IsNull(DetFac.Observaciones,'')) as [ObservacionesDetFac],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
	 Rtrim(IsNull(Articulos.Caracteristicas,Articulos.Descripcion))+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Caracteristicas],
	 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Observaciones],
	 IsNull(Articulos.AuxiliarString10,'') as [AuxiliarString10],
	 Unidades.Abreviatura as [Unidad],
	 IsNull(DetFac.NotaAclaracion,'') as [NotaAclaracion],
	 CalidadesClad.Abreviatura as [Calidad],
	 Colores.Descripcion as [Color]
	FROM DetalleFacturas DetFac
	LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON DetFac.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad
	LEFT OUTER JOIN #Auxiliar1 ON DetFac.IdDetalleFactura = #Auxiliar1.IdDetalleFactura
	LEFT OUTER JOIN Colores ON #Auxiliar1.IdColor = Colores.IdColor
	WHERE (DetFac.IdFactura = @IdFactura)
	GROUP BY DetFac.IdArticulo, DetFac.PrecioUnitario, DetFac.Bonificacion, Articulos.Codigo, Articulos.Descripcion, Unidades.Abreviatura, DetFac.NotaAclaracion, Articulos.Caracteristicas, 
		CalidadesClad.Abreviatura, DetFac.OrigenDescripcion, Colores.Descripcion, Articulos.AuxiliarString10, Convert(varchar(1000),IsNull(DetFac.Observaciones,''))
ELSE
	SELECT
	 DetFac.IdArticulo,
	 DetFac.PrecioUnitario,
	 DetFac.Bonificacion,
	 Sum(IsNull(DetFac.Cantidad,0)) as [Cantidad],
	 DetFac.PrecioUnitario,
	 Sum(Round((IsNull(DetFac.Cantidad,0)*IsNull(DetFac.PrecioUnitario,0))*(1-(IsNull(DetFac.Bonificacion,0)/100)),2)) as [Importe],
	 DetFac.OrigenDescripcion,
	 Null as [ObservacionesDetFac],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
	 Rtrim(IsNull(Articulos.Caracteristicas,Articulos.Descripcion))+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Caracteristicas],
	 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Observaciones],
	 IsNull(Articulos.AuxiliarString10,'') as [AuxiliarString10],
	 Unidades.Abreviatura as [Unidad],
	 IsNull(DetFac.NotaAclaracion,'') as [NotaAclaracion],
	 CalidadesClad.Abreviatura as [Calidad],
	 Colores.Descripcion as [Color]
	FROM DetalleFacturas DetFac
	LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON DetFac.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad
	LEFT OUTER JOIN #Auxiliar1 ON DetFac.IdDetalleFactura = #Auxiliar1.IdDetalleFactura
	LEFT OUTER JOIN Colores ON #Auxiliar1.IdColor = Colores.IdColor
	WHERE (DetFac.IdFactura = @IdFactura)
	GROUP BY DetFac.IdArticulo, DetFac.PrecioUnitario, DetFac.Bonificacion, Articulos.Codigo, Articulos.Descripcion, Unidades.Abreviatura, DetFac.NotaAclaracion, Articulos.Caracteristicas, 
		CalidadesClad.Abreviatura, DetFac.OrigenDescripcion, Colores.Descripcion, Articulos.AuxiliarString10

DROP TABLE #Auxiliar1