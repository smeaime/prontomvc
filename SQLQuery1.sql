select * from parametros2 where valor like '%esag%'

select * from puntosventa

select ImporteTopeMinimoPercepcion,AlicuotaPercepcionConvenio,AlicuotaPercepcion,* from ibcondiciones

select top 10 ibcondicion, * from clientes where idcliente=30446

select * from provincias

select * from localidades
select * from CDPEstablecimientos 
select * from  WilliamsDestinos

delete from WilliamsMailFiltrosCola
select EstadoDeCartaPorte, * from WilliamsMailFiltrosCola


select top 10 * from cartasdeporte order by fechadescarga
select top 10 * from cartasdeporte order by fechamodificacion

select vendedor,* from cartasdeporte where idcartadeporte=2638292


SELECT * FROM DiccionarioEquivalencias WHERE Palabra like '%girasol%' 







--////////////////////////////////////////////////////////////////////////////////////////
-- horas

use AdministradorProyecto

select R.IdReclamo, R.TituloReclamo + CAST( C.Comentario as varchar(2000)) ,  R.TituloReclamo,C.Comentario,c.FechaComentario  
from comentariosreclamo  C --para ver qué hiciste, revisá tus visitas a stackoverflow
left join Reclamos R on C.idreclamo=R.IdReclamo
where idusuario=125 and 
        FechaComentario between '9/28/2016' and '11/5/2016'
and (comentario like '%Test%' ) -- or not comentario like '%Reclamo%' )
order by idcomentario asc 
