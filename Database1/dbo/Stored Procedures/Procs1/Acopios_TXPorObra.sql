






CREATE  Procedure [dbo].[Acopios_TXPorObra]
@NumeroObra varchar(13)
AS 
SELECT 
	Aco.IdAcopio,
	Aco.NumeroAcopio,
	Aco.Nombre,
	Clientes.RazonSocial as [Razon social], 
	Obras.NumeroObra as [Nro. obra],
	Obras.FechaInicio as [Fecha inicio obra],
	Aco.Fecha as [Fecha acopio], 
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
WHERE rtrim(Obras.NumeroObra)=rtrim(@NumeroObra)
ORDER BY Aco.Fecha






