

select top 2 * from Facturas
order by idfactura desc

select top 5000  detallefacturas.*,facturas.observaciones from DetalleFacturas
left join facturas on facturas.idfactura=detallefacturas.idfactura
where porcentajeiva is not null
order by idfactura desc


select top 1000  * from DetalleFacturas
where porcentajeiva is not null
order by idfactura desc


select * from DetalleFacturas
where IdFactura = 100733

select * from Facturas
where IdFactura = 100733


