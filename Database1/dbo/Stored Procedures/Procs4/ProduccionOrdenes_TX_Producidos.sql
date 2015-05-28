


CREATE PROCEDURE ProduccionOrdenes_TX_Producidos
@IdObra int

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='0110000033'
SET @vector_T='01B0000000'

--pongo la oc a partir de la que se hizo la op? -eso no lo estás grabando...


SELECT distinct
	
	IdProduccionOrden,
	NumeroOrdenProduccion as Partida,
	Articulos.Descripcion as Articulo,
	OC1.IdOrdenCompra as IdOrdenCompra1,
	OC2.IdOrdenCompra as IdOrdenCompra2,
	OC3.IdOrdenCompra as IdOrdenCompra3,
	
	OC4.IdOrdenCompra as IdOrdenCompra4,
	OC5.IdOrdenCompra as IdOrdenCompra5,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

from ProduccionOrdenes OPPP
LEFT OUTER JOIN Articulos ON OPPP.IdArticuloGenerado = Articulos.IdArticulo
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


ORDER By IdProduccionOrden --NumeroOrdenProduccion --,Stock.Partida,Stock.IdArticulo
