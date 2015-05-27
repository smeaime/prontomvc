





























CREATE PROCEDURE [dbo].[DetEquipos_TXPrimero]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001133'
set @vector_T='0005500'
SELECT TOP 1
DetEqu.IdDetalleEquipo,
DetEqu.IdEquipo,
DetEqu.IdPlano,
Planos.NumeroPlano,
Planos.Descripcion,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleEquipos DetEqu
LEFT OUTER JOIN Planos ON DetEqu.IdPlano = Planos.IdPlano






























