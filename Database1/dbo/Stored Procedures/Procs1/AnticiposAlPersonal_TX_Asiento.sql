




CREATE PROCEDURE [dbo].[AnticiposAlPersonal_TX_Asiento]

@IdAsiento int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='022222500'

SELECT
 AP.IdAnticipoAlPersonal,
 Empleados.Legajo as [Legajo],
 Empleados.Nombre as [Nombre],
 AP.Importe as [Importe],
 AP.CantidadCuotas as [Cuotas],
 AP.Detalle as [Detalle],
 Empleados.CuentaBancaria as [Cuenta banco],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AnticiposAlPersonal AP
LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado
WHERE (AP.IdAsiento = @IdAsiento)




