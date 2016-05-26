-- exec Clientes_TX_RankingVentas '2012-10-01 00:00:00','2012-10-31 00:00:00'
--sp_helptext Clientes_TX_RankingVentas 

declare @Desde datetime  
declare @hasta datetime  
set @Desde='2011-12-01 00:00:00'
set @hasta='2012-10-31 00:00:00'


--exec [Clientes_TX_RankingVentasCantidades] @Desde, @hasta
--no hace falta correr el store, este pedacito da el mismo resultado 
select SUM( detallefacturas.Cantidad) 
from facturas 
inner join detallefacturas on detallefacturas.idfactura=facturas.idfactura
where facturas.idcliente=2775 --6120
	and (facturas.FechaFactura between @Desde and @hasta)
	and	(facturas.Anulada is null or facturas.Anulada<>'SI') 
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

--select * from cartasdeporte
select SUM(NetoFinal/1000) from cartasdeporte 
left join facturas on cartasdeporte.idfacturaimputada=facturas.idfactura
where facturas.idcliente=2775
	and facturas.FechaFactura between @Desde and @hasta
	and	(facturas.Anulada is null or facturas.Anulada<>'SI') 


--select facturas.idfactura,sum(NetoFinal/1000) as NetoSinDescontarMerma,sum(detallefacturas.Cantidad) as ItemsFactura
--,abs(sum(NetoFinal/1000)-sum(detallefacturas.Cantidad)) as dif
-- from facturas 
--inner join cartasdeporte on cartasdeporte.idfacturaimputada=facturas.idfactura
--inner join detallefacturas on detallefacturas.idfactura=facturas.idfactura
--where facturas.idcliente=2775
--	and facturas.FechaFactura between @Desde and @hasta
--	and	(facturas.Anulada is null or facturas.Anulada<>'SI') 
--group by facturas.idfactura
--order by abs(sum(NetoFinal/1000)-sum(detallefacturas.Cantidad)) desc


select a.IdFactura,clientes.razonsocial,cantidad,neto,abs(neto-cantidad) as dif 
from (select idfactura, sum(detallefacturas.Cantidad) as cantidad  from detallefacturas group by idfactura)  A
join (select idfacturaimputada, sum(NetoFinal/1000)  as neto from cartasdeporte group by idfacturaimputada)  B  on A.idfactura=B.idfacturaimputada
join facturas on facturas.IdFactura=a.IdFactura
join clientes on clientes.idcliente=facturas.idcliente
order by abs(neto-cantidad)  desc

go


select 
select * from DetalleFacturas where IdFactura=36284

