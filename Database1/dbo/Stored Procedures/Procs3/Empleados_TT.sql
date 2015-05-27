CREATE Procedure [dbo].[Empleados_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111133'
SET @vector_T='02922222222216200'

SELECT 
 IdEmpleado,
 Nombre as [Apellido y nombre],
 IdEmpleado as [IdAux1],
 Legajo,
 Interno as [Numero de interno],
 Sectores.Descripcion as [Sector],
 UsuarioNT as [Nombre de usuario en NT],
 Dominio as [Dominio NT],
 Email,
 Cargos.Descripcion as [Cargo],
 Administrador,
 Iniciales,
 Cuentas.Descripcion as [FF asignado],
 Obras.NumeroObra as [Obra asignada],
 IsNull(Activo,'SI') as [Activo?],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Empleados
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Cargos ON Empleados.IdCargo=Cargos.IdCargo
LEFT OUTER JOIN Cuentas ON Empleados.IdCuentaFondoFijo=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Empleados.IdObraAsignada=Obras.IdObra
ORDER BY Nombre,Legajo