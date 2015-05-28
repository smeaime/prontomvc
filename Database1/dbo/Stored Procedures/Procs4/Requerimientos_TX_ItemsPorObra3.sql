






























CREATE  Procedure [dbo].[Requerimientos_TX_ItemsPorObra3]
@IdObra int
as
select 
DetRes.IdDetalleReserva,
DetRes.IdArticulo,
DetRes.CantidadUnidades,
DetRes.Cantidad1,
DetRes.Cantidad2,
case
	when (Cantidad1 is not null and Cantidad1<>0) and (Cantidad2 is not null and Cantidad2<>0) then CantidadUnidades*Cantidad1*Cantidad2
	when Cantidad1 is not null and Cantidad1<>0 then CantidadUnidades*Cantidad1
	else CantidadUnidades
end as Cargado
FROM DetalleReservas DetRes
INNER JOIN Reservas Res ON DetRes.IdReserva = Res.IdReserva
WHERE DetRes.IdObra=@IdObra and DetRes.Estado is null































