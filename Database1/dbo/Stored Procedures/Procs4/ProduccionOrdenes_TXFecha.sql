
CREATE PROCEDURE ProduccionOrdenes_TXFecha

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON
SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='011011111111133'
set @vector_T='04401E444444100'

Select distinct
	IdProduccionOrden,
	NumeroOrdenProduccion as [Número],
	dbo.fProduccionOrdenEstado(IdProduccionOrden) as Estado,
	IdArticuloGenerado,
	Articulos.Codigo,

	Articulos.Descripcion as [Art. Producido],
	Colores.Descripcion AS [Color],
	Cantidad,
	Unidades.descripcion as [Uni.],
	FechaInicioPrevista as [Inicio Previsto],

	FechaFinalPrevista as [Final Previsto],
	FechaInicioReal as [Inicio Real],
	FechaFinalReal as [Final Real],

@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM ProduccionOrdenes
LEFT OUTER JOIN Unidades ON ProduccionOrdenes.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Articulos ON ProduccionOrdenes.IdArticuloGenerado = Articulos.IdArticulo
LEFT OUTER JOIN Colores ON ProduccionOrdenes.IdColor = Colores.IdColor
--left outer join DetalleProduccionOrdenProcesos DP ON ProduccionOrdenes.idProduccionOrden=DP.idProduccionOrden
WHERE (fechaordenproduccion Between @Desde And DATEADD(n,1439,@hasta))
ORDER BY ProduccionOrdenes.IdProduccionOrden





