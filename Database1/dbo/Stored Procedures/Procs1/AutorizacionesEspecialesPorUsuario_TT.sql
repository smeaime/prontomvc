

CREATE Procedure [dbo].[AutorizacionesEspecialesPorUsuario_TT]

AS 

SELECT 
 IdAutorizacionEspecialUsuario as [IdAutorizacionEspecialUsuario],
 Empleados.Nombre as [Usuario],
 Cuentas.Codigo as [Cod.Cuenta],
 Cuentas.Descripcion as [Cuenta]
FROM AutorizacionesEspecialesPorUsuario
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=AutorizacionesEspecialesPorUsuario.IdUsuario
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=AutorizacionesEspecialesPorUsuario.IdCuenta
ORDER BY Empleados.Nombre, Cuentas.Codigo
