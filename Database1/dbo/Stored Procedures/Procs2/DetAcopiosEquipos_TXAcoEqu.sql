





























CREATE PROCEDURE [dbo].[DetAcopiosEquipos_TXAcoEqu]
@IdAcopio int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='001133'
set @vector_T='003100'
SELECT
DetAcoEqu.IdDetalleAcopioEquipo,
DetAcoEqu.IdAcopio,
Equipos.Descripcion as [Equipo],
Equipos.Tag as [Tag],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM [DetalleAcopiosEquipos] DetAcoEqu
LEFT OUTER JOIN Equipos ON DetAcoEqu.IdEquipo = Equipos.IdEquipo
WHERE (DetAcoEqu.IdAcopio = @IdAcopio)






























