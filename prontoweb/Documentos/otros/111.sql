

select email from clientes



wResetearPass 'Mariano','pirulo!'

select * from pedidos


select  TarifaFacturada, * from CartasDePorte 
where IdFacturaImputada>0 
--where TarifaFacturada>0
order by IdCartaDePorte desc


if (select count(*) from wTempCartasPorteFacturacionAutomatica)>40000 

 DELETE wTempCartasPorteFacturacionAutomatica






-- recuperador de tarifafacturada

update CartasDePorte
set CartasDePorte.TarifaFacturada=papa.PrecioUnitario
from 

(select IdCartaDePorte,TarifaFacturada,detalleFacturas.PrecioUnitario
--cartasdeporte.IdCartaDePorte,  tarifa, TarifaFacturada,detalleFacturas.PrecioUnitario,IdFacturaImputada,detalleFacturas.idarticulo
from CartasDePorte 
join detalleFacturas on detalleFacturas.IdFactura=cartasdeporte.IdFacturaImputada and detalleFacturas.idarticulo=CartasDePorte.IdArticulo
where IdFacturaImputada>0  and TarifaFacturada=0) as papa

where CartasDePorte.IdCartaDePorte=papa.IdCartaDePorte
--group by IdCartaDePorte








