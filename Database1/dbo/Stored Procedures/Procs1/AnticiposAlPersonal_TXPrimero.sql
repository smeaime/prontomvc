




CREATE PROCEDURE [dbo].[AnticiposAlPersonal_TXPrimero]

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111133'
set @vector_T='02222200'

SELECT TOP 1 
 AP.IdAnticipoAlPersonal,
 Empleados.Legajo as [Legajo],
 Empleados.Nombre as [Nombre],
 AP.Importe as [Importe],
 AP.CantidadCuotas as [Cuotas],
 AP.Detalle as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AnticiposAlPersonal AP
LEFT OUTER JOIN Empleados ON AP.IdEmpleado = Empleados.IdEmpleado




