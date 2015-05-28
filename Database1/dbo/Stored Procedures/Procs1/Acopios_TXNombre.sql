































CREATE  Procedure [dbo].[Acopios_TXNombre]
@Nombre varchar(30)
AS 
SELECT 
	Aco.IdAcopio,
	Aco.NumeroAcopio,
	Clientes.RazonSocial,
	Obras.NumeroObra,
	Obras.FechaInicio,
	Aco.Fecha,
	( SELECT Empleados.Nombre
		FROM Empleados
		WHERE Empleados.IdEmpleado=Aco.Realizo) as  [Realizo],
	( SELECT Empleados.Nombre
		FROM Empleados
		WHERE Empleados.IdEmpleado=Aco.Aprobo) as  [Aprobo],
	Aco.Estado
FROM Acopios Aco
LEFT OUTER JOIN Clientes ON Aco.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Obras ON Aco.IdObra = Obras.IdObra
WHERE (Nombre=@Nombre)
































