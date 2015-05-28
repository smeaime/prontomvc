
CREATE Procedure [dbo].[Empleados_TX_UnUsuario]

@IdEmpleado int

AS 

SELECT 
 Empleados.Nombre as [Empleado],
 Sectores.Descripcion as [Sector],
 ea.*
FROM EmpleadosAccesos ea
LEFT OUTER JOIN Empleados ON ea.IdEmpleado=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
WHERE ea.IdEmpleado=@IdEmpleado
ORDER BY ea.IdEmpleado
