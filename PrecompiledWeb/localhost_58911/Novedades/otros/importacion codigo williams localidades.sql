select cod_procedencia, str(GEPU$.cod_procedencia) from GEPU$

select *, Localidades.codigowilliams  from Localidades

alter table localidades
	add CodigoWilliams varchar(20) null
	
alter table localidades
	add CodigoWilliams varchar(20) null



update localidades
set localidades.codigowilliams=str(GEPU$.cod_procedencia)
from Localidades
left join GEPU$ on 
	localidades.Nombre=GEPU$.localidad  collate Modern_Spanish_CI_AS
	 and cast(localidades.CodigoPostal as varchar)=cast(GEPU$.cod_postal as varchar)



select localidades.* , GEPU$.cod_procedencia
from localidades
left join GEPU$ on 
	localidades.Nombre=GEPU$.localidad  collate Modern_Spanish_CI_AS
	 and cast(localidades.CodigoPostal as varchar)=cast(GEPU$.cod_postal as varchar)



select * from GEPU$


select * from cdpestablecimientos


insert into cdpestablecimientos(descripcion,auxiliarstring1,auxiliarstring2)
select CODIGO, campo,[Cuit Comprador]
from bw6f4$



update 
set localidades.codigowilliams=str(GEPU$.cod_procedencia)
from Localidades
left join GEPU$ on 
	localidades.Nombre=GEPU$.localidad  collate Modern_Spanish_CI_AS
	 and cast(localidades.CodigoPostal as varchar)=cast(GEPU$.cod_postal as varchar)

