update listaspreciosdetalles
set preciorepetidoconprecision=precio
where preciorepetidoconprecision is null



--clientes sin lista de precios
select distinct clientes.razonsocial --,clientes.idcliente
/*
DetalleFacturas.idfactura,Facturas.numerofactura,articulos.descripcion,
FechaFactura,DetalleFacturas.IdArticulo,Facturas.IdCliente,
		clientes.IdListaPrecios,
		ListasPreciosDetalle.*
*/
from DetalleFacturas
join articulos on detallefacturas.IdArticulo=articulos.IdArticulo
join Facturas on detallefacturas.IdFactura=Facturas.idfactura
join clientes on clientes.IdCliente=Facturas.IdCliente
left join ListasPreciosDetalle on 
		ListasPreciosDetalle.IdListaPrecios=clientes.IdListaPrecios and 
		ListasPreciosDetalle.IdArticulo=DetalleFacturas.IdArticulo  
where FechaFactura>'9/21/2012'
	and (clientes.IdListaPrecios is null)
	
--order by  Facturas.idfactura desc






--clientes con lista asignada pero le falta el articulo
insert into ListasPreciosDetalle 


select distinct clientes.IdListaPrecios,DetalleFacturas.IdArticulo,DetalleFacturas.preciounitario
/*
DetalleFacturas.idfactura,Facturas.numerofactura,articulos.descripcion,clientes.razonsocial,
FechaFactura,DetalleFacturas.IdArticulo,Facturas.IdCliente,
		clientes.IdListaPrecios,
		ListasPreciosDetalle.*
*/
from DetalleFacturas
join articulos on detallefacturas.IdArticulo=articulos.IdArticulo
join Facturas on detallefacturas.IdFactura=Facturas.idfactura
join clientes on clientes.IdCliente=Facturas.IdCliente
left join ListasPreciosDetalle on 
		ListasPreciosDetalle.IdListaPrecios=clientes.IdListaPrecios and 
		ListasPreciosDetalle.IdArticulo=DetalleFacturas.IdArticulo  
where FechaFactura>'9/21/2012'
	and (ListasPreciosDetalle.IdListaPrecios is null and not clientes.IdListaPrecios is  null)

--order by  Facturas.idfactura desc





INSERT INTO ListasPreciosDetalle  (IdListaPrecios, IdArticulo,precio)
	select distinct clientes.IdListaPrecios,DetalleFacturas.IdArticulo,max(DetalleFacturas.preciounitario)
	from DetalleFacturas
	join articulos on detallefacturas.IdArticulo=articulos.IdArticulo
	join Facturas on detallefacturas.IdFactura=Facturas.idfactura
	join clientes on clientes.IdCliente=Facturas.IdCliente
	left join ListasPreciosDetalle on 
			ListasPreciosDetalle.IdListaPrecios=clientes.IdListaPrecios and 
			ListasPreciosDetalle.IdArticulo=DetalleFacturas.IdArticulo  
	where FechaFactura>'9/21/2012'
		and (ListasPreciosDetalle.IdListaPrecios is null and not clientes.IdListaPrecios is  null)
	group by clientes.IdListaPrecios,DetalleFacturas.IdArticulo
	


