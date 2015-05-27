
-------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GetEmployeeByName]
@UserName varchar(100)
 AS
SELECT 
 Empleados.*,
 Sectores.Descripcion as [Sector],
 Cargos.Descripcion as [Cargo],
 Cuentas.Descripcion as [FF_Asignado],
 Obras.NumeroObra as [ObraAsignada]
FROM Empleados
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Cargos ON Empleados.IdCargo=Cargos.IdCargo
LEFT OUTER JOIN Cuentas ON Empleados.IdCuentaFondoFijo=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Empleados.IdObraAsignada=Obras.IdObra
WHERE Empleados.UsuarioNT = @UserName
