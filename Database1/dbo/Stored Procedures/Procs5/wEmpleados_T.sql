
CREATE Procedure [dbo].[wEmpleados_T]

@IdEmpleado int = Null

AS 

SET @IdEmpleado=IsNull(@IdEmpleado,-1)

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
WHERE @IdEmpleado=-1 or Empleados.IdEmpleado=@IdEmpleado

