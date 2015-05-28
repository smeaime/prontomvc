



CREATE  Procedure [dbo].[ValesSalida_TX_ItemsPorObra1]
@IdObra int
as
select 
IdDetalleReserva,
Res.NumeroReserva,
IdArticulo,
CantidadUnidades,
Cantidad1,
Cantidad2,
case
	when (Cantidad1 is not null and Cantidad1<>0) and (Cantidad2 is not null and Cantidad2<>0) then CantidadUnidades*Cantidad1*Cantidad2
	when Cantidad1 is not null and Cantidad1<>0 then CantidadUnidades*Cantidad1
	else CantidadUnidades
end as Cargado
from DetalleReservas DetRes
INNER JOIN Reservas Res ON DetRes.IdReserva = Res.IdReserva
where DetRes.IdObra=@IdObra and DetRes.Estado is null



