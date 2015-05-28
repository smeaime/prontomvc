





























CREATE Procedure [dbo].[DetAcoCalidades_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoCalidades.IdDetalleAcoCalidad,
DetalleAcoCalidades.IdCalidad,
Calidades.Descripcion as Calidad,
DetalleAcoCalidades.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoCalidades
INNER JOIN Calidades ON DetalleAcoCalidades.IdCalidad = Calidades.IdCalidad






























