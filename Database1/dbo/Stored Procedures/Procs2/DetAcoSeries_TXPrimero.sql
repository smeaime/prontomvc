﻿





























CREATE Procedure [dbo].[DetAcoSeries_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoSeries.IdDetalleAcoSerie,
DetalleAcoSeries.IdSerie,
Series.Descripcion as Serie,
DetalleAcoSeries.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoSeries
INNER JOIN Series ON DetalleAcoSeries.IdSerie = Series.IdSerie






























