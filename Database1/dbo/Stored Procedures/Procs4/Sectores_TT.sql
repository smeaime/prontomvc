



CREATE Procedure [dbo].[Sectores_TT]
AS 
SELECT 
 Sectores.IdSector,
 Sectores.Descripcion as [Sector],
 Sectores.SeUsaEnPresupuestos as [PRONTO HH],
 Sectores.OrdenPresentacion as [Nro. orden]
FROM Sectores
LEFT OUTER JOIN Empleados ON Sectores.IdEncargado=Empleados.IdEmpleado
ORDER BY Sectores.Descripcion



