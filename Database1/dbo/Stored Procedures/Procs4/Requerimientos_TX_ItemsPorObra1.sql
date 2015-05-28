






























CREATE  Procedure [dbo].[Requerimientos_TX_ItemsPorObra1]
@IdObra int
as
select 
DetAco.idDetalleAcopios,
DetAco.IdArticulo,
DetAco.Cantidad,
DetAco.Cantidad1,
DetAco.Cantidad2,
case
	when (Cantidad1 is not null and Cantidad1<>0) and (Cantidad2 is not null and Cantidad2<>0) then Cantidad*Cantidad1*Cantidad2
	when Cantidad1 is not null and Cantidad1<>0 then Cantidad*Cantidad1
	else Cantidad
end as Cargado
from DetalleAcopios DetAco
INNER JOIN Acopios Aco ON DetAco.IdAcopio = Aco.IdAcopio
where Aco.IdObra=@IdObra































