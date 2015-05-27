CREATE Procedure [dbo].[Obras_TX_ObrasMasOT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111133'
SET @vector_T='0493377755500'

SELECT
 Obras.IdObra,
 Obras.NumeroObra as [Obra],
 'O' as [Tipo],
 CASE 	
	WHEN TipoObra=1 THEN 'Taller'
	WHEN TipoObra=2 THEN 'Montaje'
	WHEN TipoObra=3 THEN 'Servicio'
	ELSE Null
 END as [Tipo obra],
 Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS as [Cliente],
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

UNION ALL

SELECT
 OrdenesTrabajo.IdOrdenTrabajo+100000,
 OrdenesTrabajo.NumeroOrdenTrabajo COLLATE SQL_Latin1_General_CP1_CI_AS as [Obra],
 'T' as [Tipo],
 'O.Trabajo' as [Tipo obra],
 OrdenesTrabajo.Descripcion as [Cliente],
 OrdenesTrabajo.FechaInicio as [Fecha inicio],
 OrdenesTrabajo.FechaEntrega as [Fecha entrega],
 CASE 	WHEN CONVERT(varchar(8),OrdenesTrabajo.FechaFinalizacion,3)<>'01/01/00' THEN OrdenesTrabajo.FechaFinalizacion 
	ELSE Null 
 END as [Fecha finalizacion],
 Null as [Jefe de obra],
 Null as [Activa?],
 Null as [Para informes],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesTrabajo

ORDER BY [Obra]