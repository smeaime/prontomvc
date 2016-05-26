
drop FUNCTION [dbo].[CartasDePorte_CorrectorDeSubnumeroDeFacturacion]
go

CREATE FUNCTION [dbo].[CartasDePorte_CorrectorDeSubnumeroDeFacturacion]
(
	@IdDetalleFactura int
)

RETURNS int
AS
BEGIN


--tomar la menor, y forzarle un 0

update CartasDePorte
set SubnumeroDeFacturacion=0
from CartasDePorte
inner join 

(

select * from (

select NumeroCartaDePorte,SubnumeroVagon,COUNT(*) as c,min(isnull(SubnumeroDeFacturacion,0)) as s --esta es la papa. me traigo el menor subnumerodefac del grupete, y ese lo actualizo forzosamente a 0
 from cartasdeporte cdp
--where cdp.SubnumeroDeFacturacion>0 
group by NumeroCartaDePorte,SubnumeroVagon
) as A

where c >1
and s<>0

and not exists (select * from cartasdeporte where NumeroCartaDePorte=a.NumeroCartaDePorte  and  SubnumeroVagon=a.SubnumeroVagon  and SubnumeroDeFacturacion=0) 


) as U on U.NumeroCartaDePorte=CartasDePorte.NumeroCartaDePorte and  U.SubnumeroVagon=CartasDePorte.SubnumeroVagon and  U.s=CartasDePorte.SubnumeroDeFacturacion


 

 
-- select NumeroCartaDePorte,SubnumeroVagon,SubnumeroDeFacturacion,* from cartasdeporte where NumeroCartaDePorte=529298663


end
