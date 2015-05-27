CREATE PROCEDURE [dbo].[DetDevoluciones_TX_ConDatos]

@IdDevolucion int

As

SELECT
 DetDev.*,
 Devoluciones.IdCliente,
 ((DetDev.Cantidad*DetDev.PrecioUnitario)*(1-(DetDev.Bonificacion/100))) as [Importe],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Caracteristicas],
 Unidades.Abreviatura as [Unidad],
 CalidadesClad.Abreviatura as [Calidad],
 Colores.Descripcion as [Color]
FROM DetalleDevoluciones DetDev
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion = DetDev.IdDevolucion
LEFT OUTER JOIN Articulos ON DetDev.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetDev.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad
LEFT OUTER JOIN Colores ON Colores.IdColor=DetDev.IdColor
WHERE (DetDev.IdDevolucion = @IdDevolucion)