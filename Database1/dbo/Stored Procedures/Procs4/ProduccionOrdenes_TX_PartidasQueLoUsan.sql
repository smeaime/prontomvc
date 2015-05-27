

CREATE PROCEDURE ProduccionOrdenes_TX_PartidasQueLoUsan


@Partida  varchar(20)

AS 


DECLARE @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='0111111133'
SET @vector_T='0111111900'

--pongo la oc a partir de la que se hizo la op? -eso no lo estás grabando...


SELECT distinct
	isnull(OP.IdProduccionOrden,0), --OP que creó la partida
	OPPP.NumeroOrdenProduccion as [Partida],
	0 as IdStock,
	articulos.IdArticulo,
	Articulos.Codigo,
	Articulos.Descripcion,
	PP.Cantidad,
	PP.IdProduccionParte,
	OP.NumeroOrdenProduccion,
	PP.FechaDia,

	--DETOC1.IdOrdenCompra + ' ' + DETOC1.numeroitem as NumeroOC1,
	DETOC1.IdOrdenCompra as NumeroOC1,
	DETOC2.IdOrdenCompra as NumeroOC2,
	DETOC3.IdOrdenCompra as NumeroOC3,
	DETOC4.IdOrdenCompra as NumeroOC4,
	DETOC5.IdOrdenCompra as NumeroOC5,

	SM.NumeroSalidaMateriales,
	OI.NumeroOtroIngresoAlmacen,
	RECEP.NumeroRecepcion2,	
	RECEP.FechaRecepcion as FechaRecepcion,

--	remito al cliente,
--	remito del proveedor
--	Devoluciones 	

 @Vector_T as Vector_T,
 @Vector_X as Vector_X


/*
tienen que aparecer los PPs, los OI y SM generados por los 
PPs, y los remitos de recepcion del proveedor...  Tambien falta poner el Numero y la Fecha
*/

from ProduccionPartes PP
LEFT OUTER JOIN Articulos ON PP.IdArticulo=Articulos.IdArticulo
left join ProduccionOrdenes OPPP on PP.IdProduccionOrden=OPPP.IdProduccionOrden

inner join stock on Stock.Partida=ltrim(PP.Partida)
left join ProduccionOrdenes OP on Stock.Partida=ltrim(str(OP.NumeroOrdenProduccion))

left join DetalleOrdenesCompra DETOC1 on OPPP.IdDetalleOrdenCompraImputado1=DETOC1.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC2 on OPPP.IdDetalleOrdenCompraImputado2=DETOC2.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC3 on OPPP.IdDetalleOrdenCompraImputado3=DETOC3.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC4 on OPPP.IdDetalleOrdenCompraImputado4=DETOC4.IdDetalleOrdenCompra
left join DetalleOrdenesCompra DETOC5 on OPPP.IdDetalleOrdenCompraImputado5=DETOC5.IdDetalleOrdenCompra

left join DetalleRecepciones DETRECEP on Stock.Partida=DETRECEP.Partida
left join Recepciones RECEP on RECEP.IdRecepcion=DETRECEP.IdRecepcion

--left join DetalleSalidasMateriales DETSM on PP.IdSMConsumo=DETSM.IdDetalleSalidaMateriales
left join SalidasMateriales SM on SM.IdSalidaMateriales=PP.IdSMConsumo

--left join DetalleOtrosIngresosAlmacen DETOI on PP.IdOIProducto=DETOI.IdDetalleOtroIngresoAlmacen
left join OtrosIngresosAlmacen OI on OI.IdOtroIngresoAlmacen=PP.IdOIProducto



where PP.Partida=@Partida
	and not PP.idarticulo is null



