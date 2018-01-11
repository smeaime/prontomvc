use AdministradorProyecto

/*
select R.IdReclamo, R.TituloReclamo + CAST( C.Comentario as varchar(2000)) ,  R.TituloReclamo,C.Comentario,c.FechaComentario  
from comentariosreclamo  C --para ver qué hiciste, revisá tus visitas a stackoverflow
left join Reclamos R on C.idreclamo=R.IdReclamo
where 
--idusuario=125 and 
        FechaComentario between '5/28/2017' and '7/2/2017'
and (comentario like '%Testing Web%' ) -- or not comentario like '%Reclamo%' )
order by idcomentario asc 
*/




--mysql

select R.IdReclamo, concat(R.TituloReclamo, ' ', C.Comentario ),  R.TituloReclamo,C.Comentario,C.FechaComentario  
from ComentariosReclamo  C 
left join Reclamos R on C.idreclamo=R.IdReclamo
where 
        -- idusuario=125 and 
        FechaComentario between '2017/10/28' and '2018/01/5'
        and (comentario like '%Testing Web%' ) -- or not comentario like '%Reclamo%' )
order by idcomentario asc 
