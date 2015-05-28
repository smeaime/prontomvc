































CREATE  Procedure [dbo].[Acopios_TX_ItemsPorObra1]
@IdObra int
as
select 
idDetalleAcopios,Cantidad,Cantidad1,Cantidad2,
case
	when (Cantidad1 is not null and Cantidad1<>0) and (Cantidad2 is not null and Cantidad2<>0) then Cantidad*Cantidad1*Cantidad2
	when Cantidad1 is not null and Cantidad1<>0 then Cantidad*Cantidad1
	else Cantidad
end as Cargado
from DetalleLMateriales DetLMat
INNER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
where not idDetalleAcopios is null and LMat.IdObra=@IdObra
































