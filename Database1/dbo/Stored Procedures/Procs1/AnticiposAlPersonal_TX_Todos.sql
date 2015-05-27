




CREATE PROCEDURE [dbo].[AnticiposAlPersonal_TX_Todos]

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111111111133'
set @vector_T='033555555333500'

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
 Case When AP.IdOrdenPago is not null Then AP.Importe 
	Else  AP.Importe*-1
 End as [Importe],
 AP.CantidadCuotas as [Cuotas],
 AP.Detalle as [Detalle],
 Empleados.CuentaBancaria as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AnticiposAlPersonal AP
LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN OrdenesPago OP ON OP.IdOrdenPago = AP.IdOrdenPago
LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = AP.IdAsiento
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo = AP.IdRecibo
ORDER BY Empleados.Nombre,OP.FechaOrdenPago




