
CREATE Procedure [dbo].[wEmpleados_TL]
AS 
SELECT IdEmpleado, Nombre as [Titulo]
FROM Empleados
WHERE IsNull(Activo,'SI')='SI'
ORDER BY Nombre

