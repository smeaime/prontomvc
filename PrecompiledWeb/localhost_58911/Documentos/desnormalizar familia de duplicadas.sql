/*
UPDATE table 
SET Col1 = i.Col1, 
    Col2 = i.Col2 
FROM (
    SELECT ID, Col1, Col2 
    FROM other_table) i
WHERE 
    i.ID = table.ID
*/
	--http://stackoverflow.com/questions/2334712/update-from-select-using-sql-server

Update CartasDePorte  
set ConDuplicados = OTRATABLA.c
from		
(
		select Q.idcartadeporte, Q.NumeroCartaDePorte,Q.NumeroSubFijo,Q.SubNumeroVagon,REPES.c
        from  cartasdeporte as Q  
        inner join    
        (  
        select distinct NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,COUNT(*) as c
        from cartasdeporte  
        where Anulada<>'SI'  
        group by NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon  
        having     COUNT(*) > 1  
        ) as REPES on REPES.NumeroCartaDePorte=Q.NumeroCartaDePorte AND REPES.NumeroSubFijo=Q.NumeroSubFijo AND       
        REPES.SubNumeroVagon=Q.SubNumeroVagon  
) OTRATABLA
WHERE 
    OTRATABLA.idcartadeporte = CartasDePorte.idcartadeporte
go


update CartasDePorte set conduplicados=0

select conduplicados from cartasdeporte where idcartadeporte=1969885

