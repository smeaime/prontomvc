
CREATE Procedure [dbo].[Empleados_TX_TodosLosAccesos]

AS 

SELECT 
 Empleados.Nombre as [Empleado],
 Sectores.Descripcion as [Sector],
 ea.*
FROM EmpleadosAccesos ea
LEFT OUTER JOIN Empleados ON ea.IdEmpleado=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
WHERE IsNull(Activo,'SI')='SI'
ORDER BY ea.IdEmpleado
