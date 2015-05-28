































CREATE  Procedure [dbo].[Acopios_TX_PorEquipo_Todo]
@IdEquipo int
AS 
SELECT DISTINCT 
Aco.IdAcopio,
Aco.NumeroAcopio,
Aco.Nombre,
Clientes.RazonSocial as [Cliente], 
Obras.NumeroObra as [Nro. obra],
Obras.FechaInicio as [Fecha inicio obra],
Aco.Fecha as [Fecha acopio], 
( SELECT Empleados.Nombre
  FROM Empleados
  WHERE Empleados.IdEmpleado=Aco.Realizo) as  [Emitido por],
( SELECT Empleados.Nombre
  FROM Empleados
  WHERE Empleados.IdEmpleado=Aco.Aprobo) as  [Liberado por],
Aco.Estado,
( SELECT Count(*) 
  FROM DetalleAcopios Where DetalleAcopios.IdAcopio=Aco.IdAcopio) as [Cant.Items]
FROM DetalleAcopios
LEFT OUTER JOIN Acopios Aco ON DetalleAcopios.IdAcopio=Aco.IdAcopio
LEFT OUTER JOIN Clientes ON Aco.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Obras ON Aco.IdObra = Obras.IdObra
WHERE DetalleAcopios.IdEquipo=@IdEquipo
ORDER BY Aco.NumeroAcopio
































