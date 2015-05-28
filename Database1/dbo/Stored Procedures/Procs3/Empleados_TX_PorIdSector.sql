

CREATE Procedure [dbo].[Empleados_TX_PorIdSector]
@IdSector int
AS 
SELECT 
 Empleados.Nombre as [Empleado],
 Sectores.Descripcion as [Sector],
 ea.*
FROM EmpleadosAccesos ea
LEFT OUTER JOIN Empleados ON ea.IdEmpleado=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
WHERE Empleados.IdSector=@IdSector and IsNull(Activo,'SI')='SI'
ORDER BY ea.IdEmpleado

