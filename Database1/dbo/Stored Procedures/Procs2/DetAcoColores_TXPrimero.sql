





























CREATE Procedure [dbo].[DetAcoColores_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoColores.IdDetalleAcoColor,
DetalleAcoColores.IdColor,
Colores.Descripcion as Color,
DetalleAcoColores.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoColores
INNER JOIN Colores ON DetalleAcoColores.IdColor = Colores.IdColor






























