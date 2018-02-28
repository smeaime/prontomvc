exec Cuentas_TT
Cuentas_TX_PorCodigo 1006



select * from reclamocomentarios
select * from empleados

select * from reclamos
select top 10 * from cartasdeporte 
where idcartadeporte=2633399  
order by idcartadeporte desc



select top 2 * from Facturas
order by idfactura desc



select
--top 5000  
--detallefacturas.*,
facturas.observaciones,
facturas.puntoventa, facturas.numerofactura
from DetalleFacturas
left join facturas on facturas.idfactura=detallefacturas.idfactura
where porcentajeiva is not null and (facturas.observaciones like '%periodo%' or facturas.observaciones like '%corredor%')
order by detallefacturas.idfactura desc



select top 1000 DetalleFacturas.*,facturas.importeiva1
from DetalleFacturas
left join facturas on facturas.idfactura=detallefacturas.idfactura
--where porcentajeiva is not null
order by idfactura desc


select * from DetalleFacturas
where IdFactura = 100733

select observaciones,* from Facturas
where IdFactura = 100733


select detallefacturas.*,facturas.observaciones,clientes.razonsocial,facturas.puntoventa, facturas.*
from DetalleFacturas
left join facturas on facturas.idfactura=detallefacturas.idfactura
left join clientes on facturas.idcliente=clientes.idcliente
where 
--numerofactura = 13570 and puntoventa=20
(facturas.numerofactura = 6515 and facturas.puntoventa=20) OR
(facturas.numerofactura = 13570 and facturas.puntoventa=20) OR
(facturas.numerofactura = 14396 and facturas.puntoventa=20) 



