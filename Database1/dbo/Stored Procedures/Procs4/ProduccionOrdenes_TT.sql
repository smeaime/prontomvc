
CREATE  Procedure ProduccionOrdenes_TT

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


	OC1.NumeroOrdenCompra as NumeroOC1,
	OC2.NumeroOrdenCompra as NumeroOC2,
	OC3.NumeroOrdenCompra as NumeroOC3,
	OC4.NumeroOrdenCompra as NumeroOC4,
	OC5.NumeroOrdenCompra as NumeroOC5,
	
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM ProduccionOrdenes OPPP
LEFT OUTER JOIN Unidades ON OPPP.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON OPPP.IdColor = Colores.IdColor
LEFT OUTER JOIN Articulos ON OPPP.IdArticuloGenerado = Articulos.IdArticulo
--INNER JOIN Subrubros ON AcoSeries.IdSubrubro = Subrubros.IdSubrubro

left join DetalleOrdenesCompra DETOC1 on OPPP.IdDetalleOrdenCompraImputado1=DETOC1.IdDetalleOrdenCompra
left join OrdenesCompra OC1 on DETOC1.IdOrdenCompra=OC1.IdOrdenCompra
left join DetalleOrdenesCompra DETOC2 on OPPP.IdDetalleOrdenCompraImputado2=DETOC2.IdDetalleOrdenCompra
left join OrdenesCompra OC2 on DETOC2.IdOrdenCompra=OC2.IdOrdenCompra
left join DetalleOrdenesCompra DETOC3 on OPPP.IdDetalleOrdenCompraImputado3=DETOC3.IdDetalleOrdenCompra
left join OrdenesCompra OC3 on DETOC3.IdOrdenCompra=OC3.IdOrdenCompra
left join DetalleOrdenesCompra DETOC4 on OPPP.IdDetalleOrdenCompraImputado4=DETOC4.IdDetalleOrdenCompra
left join OrdenesCompra OC4 on DETOC4.IdOrdenCompra=OC4.IdOrdenCompra
left join DetalleOrdenesCompra DETOC5 on OPPP.IdDetalleOrdenCompraImputado5=DETOC5.IdDetalleOrdenCompra
left join OrdenesCompra OC5 on DETOC5.IdOrdenCompra=OC5.IdOrdenCompra
ORDER BY OPPP.IdProduccionOrden DESC

