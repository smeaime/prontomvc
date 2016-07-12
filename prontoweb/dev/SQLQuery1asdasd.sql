select facturas.idfactura from facturas 

left join cartasdeporte on cartasdeporte.idfacturaimputada=facturas.idfactura
where cartasdeporte.idfacturaimputada is null
order by idfactura desc
--select idfacturaimputada from cartasdeporte