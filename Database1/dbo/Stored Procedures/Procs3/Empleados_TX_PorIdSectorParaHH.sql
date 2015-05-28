































CREATE Procedure [dbo].[Empleados_TX_PorIdSectorParaHH]
@IdSector int
AS 
SELECT 
e.IdEmpleado as [Id],
e.Nombre as [Operario]
FROM Empleados e
WHERE IdSector=@IdSector and SisMan='SI' 
ORDER BY e.Nombre
































