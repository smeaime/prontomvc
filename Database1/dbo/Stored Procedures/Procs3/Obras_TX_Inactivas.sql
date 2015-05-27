CREATE Procedure [dbo].[Obras_TX_Inactivas]

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111111111133'
set @vector_T='0433255555500'

SELECT 
Obras.IdObra,
Obras.NumeroObra as [Obra],
CASE 	
	WHEN TipoObra=1 THEN 'Taller'
	WHEN TipoObra=2 THEN 'Montaje'
	WHEN TipoObra=3 THEN 'Servicio'
	ELSE Null
END as [Tipo obra],
Clientes.Codigo as [Codigo],
Clientes.RazonSocial as [Cliente],
Obras.FechaInicio as [Fecha inicio],
Obras.FechaEntrega as [Fecha entrega],
CASE 	WHEN CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' THEN Obras.FechaFinalizacion 
	ELSE Null 
END as [Fecha finalizacion],
Empleados.Nombre as [Jefe de obra],
Obras.Activa as [Activa?],
Obras.ParaInformes as [Para informes],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Obras
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Empleados ON Obras.IdJefe = Empleados.IdEmpleado
WHERE Obras.Activa='NO'
ORDER BY Obras.NumeroObra