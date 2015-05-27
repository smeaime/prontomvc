CREATE PROCEDURE [dbo].[DetDevoluciones_TX_ConDatosAgrupados]

@IdDevolucion int

AS

SELECT
 DetDev.IdArticulo,
 DetDev.PrecioUnitario,
 DetDev.Bonificacion,
 Sum(IsNull(DetDev.Cantidad,0)) as [Cantidad],
 DetDev.PrecioUnitario,
 Sum(Round((IsNull(DetDev.Cantidad,0)*IsNull(DetDev.PrecioUnitario,0))*(1-(IsNull(DetDev.Bonificacion,0)/100)),2)) as [Importe],
 DetDev.OrigenDescripcion,
 Convert(varchar(1000),IsNull(DetDev.Observaciones,'')) as [ObservacionesDetFac],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
 Rtrim(IsNull(Articulos.Caracteristicas,Articulos.Descripcion))+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Caracteristicas],
 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Observaciones],
 IsNull(Articulos.AuxiliarString10,'') as [AuxiliarString10],
 Unidades.Abreviatura as [Unidad],
 Colores.Descripcion as [Color]
FROM DetalleDevoluciones DetDev
LEFT OUTER JOIN Articulos ON DetDev.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetDev.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON DetDev.IdColor = Colores.IdColor
WHERE (DetDev.IdDevolucion = @IdDevolucion)
GROUP BY DetDev.IdArticulo, DetDev.PrecioUnitario, DetDev.Bonificacion, Articulos.Codigo, Articulos.Descripcion, Unidades.Abreviatura, Articulos.Caracteristicas, 
	DetDev.OrigenDescripcion, Colores.Descripcion, Articulos.AuxiliarString10, Convert(varchar(1000),IsNull(DetDev.Observaciones,''))