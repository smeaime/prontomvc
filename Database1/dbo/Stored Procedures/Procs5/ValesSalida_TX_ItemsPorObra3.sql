





























CREATE  Procedure [dbo].[ValesSalida_TX_ItemsPorObra3]
@IdObra int
as
select 
DetVal.IdDetalleLMateriales,
DetVal.IdDetalleReserva,
DetVal.IdArticulo,
DetVal.Cantidad,
DetVal.Cantidad1,
DetVal.Cantidad2,
case
	when (DetVal.Cantidad1 is not null and DetVal.Cantidad1<>0) and (DetVal.Cantidad2 is not null and DetVal.Cantidad2<>0) then DetVal.Cantidad*DetVal.Cantidad1*DetVal.Cantidad2
	when DetVal.Cantidad1 is not null and DetVal.Cantidad1<>0 then DetVal.Cantidad*DetVal.Cantidad1
	else DetVal.Cantidad
end as Preparado
from DetalleValesSalida DetVal
LEFT OUTER JOIN ValesSalida ON DetVal.IdValeSalida = ValesSalida.IdValeSalida
WHERE ValesSalida.IdObra=@IdObra and DetVal.Estado is null






























