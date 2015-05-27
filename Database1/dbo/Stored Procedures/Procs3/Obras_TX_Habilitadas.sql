CREATE Procedure [dbo].[Obras_TX_Habilitadas]

@IdUsuario int = Null

AS 

SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111133'
SET @vector_T='0438355555500'

SELECT 
 Obras.IdObra,
 Obras.NumeroObra as [Obra],
 CASE 	
	WHEN TipoObra=1 THEN 'Taller'
	WHEN TipoObra=2 THEN 'Montaje'
	WHEN TipoObra=3 THEN 'Servicio'
	ELSE Null
 END as [Tipo obra],
 Obras.Descripcion as [Descripcion obra],
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
WHERE Obras.FechaFinalizacion is null and 
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and deo.IdObra=Obras.IdObra))
ORDER BY Obras.NumeroObra