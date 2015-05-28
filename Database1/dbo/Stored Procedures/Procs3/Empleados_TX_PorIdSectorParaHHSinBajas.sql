































CREATE Procedure [dbo].[Empleados_TX_PorIdSectorParaHHSinBajas]
@IdSector int,
@Fecha datetime
AS 
SELECT 
e.IdEmpleado as [Id],
e.Nombre as [Operario]
FROM Empleados e
WHERE IdSector=@IdSector and SisMan='SI' and 
	(Exists(Select * from DetalleEmpleados de
		Where e.IdEmpleado=de.IdEmpleado and 
			(@Fecha between de.FechaIngreso and de.FechaEgreso) and de.FechaEgreso is not null)
	 Or 
	 Exists(Select * from DetalleEmpleados de
		Where e.IdEmpleado=de.IdEmpleado and @Fecha>=de.FechaIngreso and de.FechaEgreso is null) )
ORDER BY e.Nombre
































