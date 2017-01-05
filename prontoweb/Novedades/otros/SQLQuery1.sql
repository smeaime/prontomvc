use AdministradorProyecto

select R.IdReclamo, R.TituloReclamo + CAST( C.Comentario as varchar(2000)) ,  R.TituloReclamo,C.Comentario,c.FechaComentario  
from comentariosreclamo  C --para ver qué hiciste, revisá tus visitas a stackoverflow
left join Reclamos R on C.idreclamo=R.IdReclamo
where idusuario=125 and 
        FechaComentario between '11/28/2016' and '5/1/2017'
and (comentario like '%Test%' ) -- or not comentario like '%Reclamo%' )
order by idcomentario asc 