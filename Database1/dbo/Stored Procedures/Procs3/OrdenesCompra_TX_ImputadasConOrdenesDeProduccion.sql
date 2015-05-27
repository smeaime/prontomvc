


CREATE PROCEDURE OrdenesCompra_TX_ImputadasConOrdenesDeProduccion
AS 


SELECT distinct
	OC.idOrdenCompra,
	cast(OC.NumeroOrdenCompra as varchar(50)) + ' '+ cast(CLI.RazonSocial as varchar(100)) as Titulo

FROM DetalleOrdenesCompra DETOC
left join OrdenesCompra OC on DETOC.IdOrdenCompra=OC.IdOrdenCompra
left join Clientes CLI on OC.idcliente=CLI.idcliente
WHERE idDetalleOrdenCompra in
	(
	select IdDetalleOrdenCompraImputado1 from ProduccionOrdenes
	union
	select IdDetalleOrdenCompraImputado2 from ProduccionOrdenes
	union
	select IdDetalleOrdenCompraImputado3 from ProduccionOrdenes
	union
	select IdDetalleOrdenCompraImputado4 from ProduccionOrdenes
	union
	select IdDetalleOrdenCompraImputado5 from ProduccionOrdenes
	)
ORDER BY OC.idOrdenCompra DESC



