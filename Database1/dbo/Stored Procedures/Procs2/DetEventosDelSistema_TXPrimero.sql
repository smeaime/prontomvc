





























CREATE PROCEDURE [dbo].[DetEventosDelSistema_TXPrimero]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001133'
set @vector_T='0005500'
SELECT TOP 1
DetEv.IdDetalleEventoDelSistema,
DetEv.IdEventoDelSistema,
DetEv.IdEmpleado,
Empleados.Legajo as [Legajo],
Empleados.Nombre as [Apellido y nombre],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleEventosDelSistema DetEv
LEFT OUTER JOIN Empleados ON DetEv.IdEmpleado=Empleados.IdEmpleado






























