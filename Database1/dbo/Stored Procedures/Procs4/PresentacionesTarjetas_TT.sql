CREATE  Procedure [dbo].[PresentacionesTarjetas_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111111133'
SET @vector_T='00295612500'

SELECT 
 PresentacionesTarjetas.IdPresentacionTarjeta,
 PresentacionesTarjetas.IdTarjetaCredito,
 TarjetasCredito.Nombre as [Tarjeta],
 PresentacionesTarjetas.IdPresentacionTarjeta as [IdAux],
 PresentacionesTarjetas.FechaIngreso as [Fecha ingreso],
 PresentacionesTarjetas.NumeroPresentacion as [Nro.Presentacion],
 PresentacionesTarjetas.Observaciones as [Observaciones],
 Empleados.Nombre  as [Realizo],
 (Select Count(*) From DetallePresentacionesTarjetas dpt Where dpt.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta) as [Cant.Cupones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PresentacionesTarjetas
LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=PresentacionesTarjetas.IdTarjetaCredito
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=PresentacionesTarjetas.IdRealizo
ORDER BY TarjetasCredito.Nombre, PresentacionesTarjetas.FechaIngreso, PresentacionesTarjetas.NumeroPresentacion