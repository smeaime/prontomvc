


CREATE Procedure [dbo].[Empleados_TX_TT2]
AS 
SELECT E.IdEmpleado, E.Nombre as [Titulo], C1.Descripcion as [Cargo]
FROM Empleados E
LEFT OUTER JOIN Sectores S1 ON S1.IdSector=E.IdSector
LEFT OUTER JOIN Sectores S2 ON S2.IdSector=E.IdSector1
LEFT OUTER JOIN Sectores S3 ON S3.IdSector=E.IdSector2
LEFT OUTER JOIN Sectores S4 ON S4.IdSector=E.IdSector3
LEFT OUTER JOIN Sectores S5 ON S5.IdSector=E.IdSector4
LEFT OUTER JOIN Cargos C1 ON C1.IdCargo=E.IdCargo
LEFT OUTER JOIN Cargos C2 ON C2.IdCargo=E.IdCargo1
LEFT OUTER JOIN Cargos C3 ON C3.IdCargo=E.IdCargo2
LEFT OUTER JOIN Cargos C4 ON C4.IdCargo=E.IdCargo3
LEFT OUTER JOIN Cargos C5 ON C5.IdCargo=E.IdCargo4
ORDER BY E.Nombre
