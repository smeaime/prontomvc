






























CREATE  Procedure [dbo].[Requerimientos_TX_ItemsPorObra2]
@IdObra int
as
select 
DetReq.idDetalleRequerimiento,
DetReq.IdArticulo,
DetReq.Cantidad,
DetReq.Cantidad1,
DetReq.Cantidad2,
case
	when (Cantidad1 is not null and Cantidad1<>0) and (Cantidad2 is not null and Cantidad2<>0) then Cantidad*Cantidad1*Cantidad2
	when Cantidad1 is not null and Cantidad1<>0 then Cantidad*Cantidad1
	else Cantidad
end as Cargado
from DetalleRequerimientos DetReq
INNER JOIN Requerimientos Req ON DetReq.IdRequerimiento = Req.IdRequerimiento
where Req.IdObra=@IdObra































