





























CREATE PROCEDURE [dbo].[DetReservas_TXPrimero]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001111111133'
set @vector_T='0001102210000'
SELECT TOP 1
DetAju.IdDetalleReserva,
DetAju.IdReserva,
DetAju.IdArticulo,
Articulos.Descripcion as Articulo,
DetAju.Partida,
DetAju.CantidadUnidades as [Cant.],
DetAju.Cantidad1 as [Med.1],
DetAju.Cantidad2 as [Med.2],
Unidades.Descripcion as [En :],
DetAju.Retirada as [Ret?],
DetAju.Estado as [Est],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleReservas DetAju
LEFT OUTER JOIN Articulos ON DetAju.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetAju.IdUnidad = Unidades.IdUnidad






























