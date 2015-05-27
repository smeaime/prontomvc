CREATE Procedure [dbo].[Obras_TX_DatosDeLaObra]

@IdObra int

AS 

SELECT 
 Obras.IdObra,
 Obras.NumeroObra as [Obra],
 Obras.Descripcion as [Descripcion],
 Clientes.RazonSocial as [Cliente],
 Clientes.Cuit as [Cuit],
 Obras.FechaInicio as [Fecha inicio],
 Obras.FechaEntrega as [Fecha entrega],
 CASE 	WHEN CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' THEN Obras.FechaFinalizacion 
	ELSE Null 
 END as [Fecha finalizacion],
 Obras.HorasEstimadas,
 Obras.Consorcial,
 Obras.Direccion, 
 Obras.Telefono, 
 Obras.Responsable,
 Obras.CodigoPostal, 
 Localidades.Nombre as [Localidad], 
 Provincias.Nombre as [Provincia], 
 Paises.Descripcion as [Pais],
 Empleados.Nombre as [JefeObra],
 DescripcionIva.Descripcion as [DescripcionIva]
FROM Obras
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Localidades ON Obras.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Obras.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Obras.IdPais = Paises.IdPais
LEFT OUTER JOIN Empleados ON Obras.IdJefe = Empleados.IdEmpleado
LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva = Clientes.IdCodigoIva
WHERE IdObra=@IdObra