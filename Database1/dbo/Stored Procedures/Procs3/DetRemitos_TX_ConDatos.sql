CREATE Procedure [dbo].[DetRemitos_TX_ConDatos]

@IdRemito int,
@IdDetalleRemito int = Null

AS

SET @IdDetalleRemito=IsNull(@IdDetalleRemito,-1)

SELECT
 DetRem.*,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 IsNull(Articulos.Caracteristicas,Articulos.Descripcion) as [Caracteristicas],
 U1.Abreviatura as [Unidad],
 U2.UnidadesPorPack as [UnidadesPorPack],
 CalidadesClad.Abreviatura as [Calidad],
 UnidadesEmpaque.PesoBruto,
 UnidadesEmpaque.Tara,
 UnidadesEmpaque.PesoNeto,
 Colores.Descripcion as [Color]
FROM DetalleRemitos DetRem
LEFT OUTER JOIN Articulos ON DetRem.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades U1 ON DetRem.IdUnidad = U1.IdUnidad
LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = DetRem.IdDetalleOrdenCompra
LEFT OUTER JOIN CalidadesClad ON Articulos.IdCalidadClad = CalidadesClad.IdCalidadClad
LEFT OUTER JOIN UnidadesEmpaque ON DetRem.NumeroCaja = UnidadesEmpaque.NumeroUnidad
LEFT OUTER JOIN Unidades U2 ON UnidadesEmpaque.IdUnidadTipoCaja = U2.IdUnidad
LEFT OUTER JOIN Colores ON IsNull(UnidadesEmpaque.IdColor,doc.IdColor) = Colores.IdColor
WHERE (@IdRemito>0 and DetRem.IdRemito = @IdRemito) or (@IdDetalleRemito>0 and DetRem.IdDetalleRemito=@IdDetalleRemito)
ORDER BY doc.NumeroItem, DetRem.NumeroItem