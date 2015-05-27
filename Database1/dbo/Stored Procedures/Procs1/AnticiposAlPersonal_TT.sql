




CREATE PROCEDURE [dbo].[AnticiposAlPersonal_TT]

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111133'
set @vector_T='03355555533300'

SELECT
 AP.IdAnticipoAlPersonal,
 Empleados.Legajo as [Legajo],
 Empleados.Nombre as [Nombre],
 OP.NumeroOrdenPago as [O.Pago],
 OP.FechaOrdenPago as [Fecha anticipo],
 Asientos.NumeroAsiento as [Asiento],
 Asientos.FechaAsiento as [Fecha asiento],
 Recibos.NumeroRecibo AS [Recibo], 
 Recibos.FechaRecibo AS [Fecha Recibo], 
 AP.Importe as [Importe],
 AP.CantidadCuotas as [Cuotas],
 AP.Detalle as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AnticiposAlPersonal AP
LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN OrdenesPago OP ON OP.IdOrdenPago = AP.IdOrdenPago
LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = AP.IdAsiento
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo = AP.IdRecibo




