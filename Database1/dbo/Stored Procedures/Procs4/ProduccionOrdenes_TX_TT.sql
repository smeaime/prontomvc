
CREATE  Procedure ProduccionOrdenes_TX_TT
@IdProduccionOrden int


AS 

declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='01101111111111111133'
set @vector_T='04401E44444410000000'
Select 
	IdProduccionOrden,
	NumeroOrdenProduccion as [Número],
	dbo.fProduccionOrdenEstado(IdProduccionOrden) as Estado,
	IdArticuloGenerado,
	Articulos.Codigo,

	Articulos.Descripcion as [Art. Producido],
	Colores.Descripcion AS [Color],
	OPPP.Cantidad,
	Unidades.descripcion as [Uni.],
	FechaInicioPrevista as [Inicio Previsto],

	FechaFinalPrevista as [Final Previsto],
	FechaInicioReal as [Inicio Real],
	FechaFinalReal as [Final Real],

	DETOC1.IdOrdenCompra as NumeroOC1,
	--DETOC2.IdOrdenCompra as NumeroOC2,
	--DETOC3.IdOrdenCompra as NumeroOC3,
	--DETOC4.IdOrdenCompra as NumeroOC4,
	--DETOC5.IdOrdenCompra as NumeroOC5,


@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM ProduccionOrdenes OPPP
LEFT OUTER JOIN Unidades ON OPPP.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON OPPP.IdColor = Colores.IdColor
LEFT OUTER JOIN Articulos ON OPPP.IdArticuloGenerado = Articulos.IdArticulo

left join DetalleOrdenesCompra DETOC1 on OPPP.IdDetalleOrdenCompraImputado1=DETOC1.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC2 on OPPP.IdDetalleOrdenCompraImputado2=DETOC2.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC3 on OPPP.IdDetalleOrdenCompraImputado3=DETOC3.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC4 on OPPP.IdDetalleOrdenCompraImputado4=DETOC4.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC5 on OPPP.IdDetalleOrdenCompraImputado5=DETOC5.IdDetalleOrdenCompra


--INNER JOIN Subrubros ON AcoSeries.IdSubrubro = Subrubros.IdSubrubro
WHERE (IdProduccionOrden=@IdProduccionOrden)
ORDER BY OPPP.FechaOrdenProduccion

