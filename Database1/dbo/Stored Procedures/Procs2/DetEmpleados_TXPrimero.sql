﻿





























CREATE PROCEDURE [dbo].[DetEmpleados_TXPrimero]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='001133'
set @vector_T='005500'
SELECT TOP 1
DetEqu.IdDetalleEmpleado,
DetEqu.IdEmpleado,
DetEqu.FechaIngreso,
DetEqu.FechaEgreso,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleEmpleados DetEqu






























