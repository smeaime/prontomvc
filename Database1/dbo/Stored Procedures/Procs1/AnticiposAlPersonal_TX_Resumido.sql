




CREATE PROCEDURE [dbo].[AnticiposAlPersonal_TX_Resumido]

@FechaDesde datetime,
@FechaHasta datetime,
@Desde int,
@Hasta int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111133'
set @vector_T='0555500'

SELECT
 AP.IdEmpleado,
 Empleados.Legajo as [Legajo],
 Empleados.Nombre as [Nombre],
 SUM(Case When AP.IdOrdenPago is not null Then AP.Importe * OP.CotizacionMoneda 
	When AP.IdRecibo is not null Then AP.Importe * RE.CotizacionMoneda * -1 
	Else  AP.Importe * -1 End) as [Importe],
 Empleados.CuentaBancaria as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AnticiposAlPersonal AP
LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN OrdenesPago OP ON OP.IdOrdenPago = AP.IdOrdenPago
LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = AP.IdAsiento
LEFT OUTER JOIN Recibos RE ON RE.IdRecibo = AP.IdRecibo
WHERE Empleados.Legajo>=@Desde and Empleados.Legajo<=@Hasta and 
	((AP.IdOrdenPago is not null and OP.FechaOrdenPago<=@FechaHasta) or 
	 (AP.IdAsiento is not null and Asientos.FechaAsiento<=@FechaHasta) or 
	 (AP.IdRecibo is not null and RE.FechaRecibo<=@FechaHasta))
GROUP BY AP.IdEmpleado,Empleados.Legajo,Empleados.Nombre,Empleados.CuentaBancaria




