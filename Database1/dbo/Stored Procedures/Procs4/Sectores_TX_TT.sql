



CREATE Procedure [dbo].[Sectores_TX_TT]
@IdSector int
AS 
SELECT
 Sectores.IdSector,
 Sectores.Descripcion as [Sector],
 Sectores.SeUsaEnPresupuestos as [PRONTO HH],
 Sectores.OrdenPresentacion as [Nro. orden]
FROM Sectores
LEFT OUTER JOIN Empleados ON Sectores.IdEncargado=Empleados.IdEmpleado
WHERE (Sectores.IdSector=@IdSector)



