





























CREATE PROCEDURE [dbo].[Reservas_TX_Todas]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000111111111133'
set @vector_T='000143311220100'
SELECT
DetRes.IdDetalleReserva,
DetRes.IdReserva,
DetRes.IdArticulo,
Reservas.NumeroReserva as [Reserva],
Reservas.FechaReserva as [Fecha],
Obras.NumeroObra as [Obra],
Articulos.Descripcion as [Articulo],
DetRes.Partida,
DetRes.CantidadUnidades as [Cant.],
DetRes.Cantidad1 as [Med.1],
DetRes.Cantidad2 as [Med.2],
Unidades.Descripcion as [En :],
DetRes.Retirada as [Retiró?],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleReservas DetRes
LEFT OUTER JOIN Reservas ON DetRes.IdReserva = Reservas.IdReserva
LEFT OUTER JOIN Obras ON DetRes.IdObra = Obras.IdObra
LEFT OUTER JOIN Articulos ON DetRes.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetRes.IdUnidad = Unidades.IdUnidad
WHERE DetRes.Retirada is null or DetRes.Retirada<>'SI'






























