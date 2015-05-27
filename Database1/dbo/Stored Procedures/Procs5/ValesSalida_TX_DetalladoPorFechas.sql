





























CREATE PROCEDURE [dbo].[ValesSalida_TX_DetalladoPorFechas]
@Desde datetime,
@Hasta datetime
as
SELECT
DetVal.IdValeSalida,
ValesSalida.NumeroValePreimpreso as [Preimpreso],
ValesSalida.NumeroValeSalida as [Vale],
Obras.NumeroObra as [Obra],
Equipos.Descripcion as [Equipo],
Null as [Codigo],
Unidades.Abreviatura as [Unidad],
Articulos.Descripcion as [Descripcion],
DetVal.Cantidad as [Cantidad],
DetVal.Cantidad1 as [Med1],
DetVal.Cantidad2 as [Med2],
Null as [Precio],
Null as [ConsumoValorizado],
Null as [ConsumoObraEquipo]
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN Articulos ON DetVal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetVal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN ValesSalida ON DetVal.IdValeSalida= ValesSalida.IdValeSalida
LEFT OUTER JOIN Obras ON ValesSalida.IdObra=Obras.IdObra
LEFT OUTER JOIN DetalleLMateriales ON DetVal.IdDetalleLMateriales=DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
WHERE ValesSalida.FechaValeSalida>=@Desde and ValesSalida.FechaValeSalida<=@Hasta
ORDER BY Articulos.Descripcion






























