--select SubnumeroDeFacturacion,* from cartasdeporte where numerocartadeporte=546818635 

select Q.NumeroCartaDePorte,Q.NumeroSubFijo,Q.SubNumeroVagon from cartasdeporte as Q
inner join  
(
select NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon --, COUNT (NumeroCartaDePorte) as cant
from cartasdeporte
where Anulada<>'SI'
group by NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon
having     COUNT(NumeroCartaDePorte) > 1
) as REPES on REPES.NumeroCartaDePorte=Q.NumeroCartaDePorte AND REPES.NumeroSubFijo=Q.NumeroSubFijo AND REPES.SubNumeroVagon=Q.SubNumeroVagon
where SubNumeroDefacturacion =-1
--order by Q.cant desc



update cartasdeporte 
set SubNumeroDefacturacion =  
(
	select max(SubNumeroDefacturacion) from cartasdeporte as Q2 
		where  
			Q2.NumeroCartaDePorte=NumeroCartaDePorte AND 
			Q2.NumeroSubFijo=NumeroSubFijo AND 
			Q2.SubNumeroVagon=SubNumeroVagon
)+1
select Q.NumeroCartaDePorte,Q.NumeroSubFijo,Q.SubNumeroVagon
from  cartasdeporte as Q
inner join  
(
select NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon --, COUNT (NumeroCartaDePorte) as cant
from cartasdeporte
where Anulada<>'SI'
group by NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon
having     COUNT(NumeroCartaDePorte) > 1
) as REPES on REPES.NumeroCartaDePorte=Q.NumeroCartaDePorte AND REPES.NumeroSubFijo=Q.NumeroSubFijo AND REPES.SubNumeroVagon=Q.SubNumeroVagon
where SubNumeroDefacturacion =-1
