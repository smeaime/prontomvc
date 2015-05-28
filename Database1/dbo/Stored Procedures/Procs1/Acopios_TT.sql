































CREATE  Procedure [dbo].[Acopios_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111133'
set @vector_T='05555555555900'
SELECT 
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
  FROM DetalleAcopios Where DetalleAcopios.IdAcopio=Aco.IdAcopio) as [Cant.Items],
Aco.IdAcopio,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Acopios Aco
LEFT OUTER JOIN Clientes ON Aco.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Obras ON Aco.IdObra = Obras.IdObra
WHERE (Aco.Estado is null or Aco.Estado='NO')
ORDER BY Aco.NumeroAcopio
































