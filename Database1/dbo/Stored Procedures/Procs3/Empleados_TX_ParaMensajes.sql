































CREATE Procedure [dbo].[Empleados_TX_ParaMensajes]
AS 
Select 
IdEmpleado,
Nombre as [Apellido y nombre],
Sectores.Descripcion as [Sector],
Cargos.Descripcion as [Cargo],
Email
FROM Empleados
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Cargos ON Empleados.IdCargo=Cargos.IdCargo
ORDER by Nombre
































