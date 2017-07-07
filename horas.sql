use AdministradorProyecto

select R.IdReclamo, R.TituloReclamo + CAST( C.Comentario as varchar(2000)) ,  R.TituloReclamo,C.Comentario,c.FechaComentario  
from comentariosreclamo  C --para ver qué hiciste, revisá tus visitas a stackoverflow
left join Reclamos R on C.idreclamo=R.IdReclamo
where 
--idusuario=125 and 
        FechaComentario between '5/28/2017' and '7/2/2017'
and (comentario like '%Testing Web%' ) -- or not comentario like '%Reclamo%' )
order by idcomentario asc 




