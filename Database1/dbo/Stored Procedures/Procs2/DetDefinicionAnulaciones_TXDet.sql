


CREATE PROCEDURE [dbo].[DetDefinicionAnulaciones_TXDet]

@IdDefinicionAnulacion int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111133'
Set @vector_T='0100200'

SELECT
 Det.IdDetalleDefinicionAnulacion,
 Empleados.Nombre as [Usuario],
 Cargos.Descripcion as [Cargo],
 Sectores.Descripcion as [Sector],
 Det.Administradores as [Administradores],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDefinicionAnulaciones Det
LEFT OUTER JOIN Empleados ON Det.IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN Cargos ON Det.IdCargo = Cargos.IdCargo
LEFT OUTER JOIN Sectores ON Det.IdSector = Sectores.IdSector
WHERE (Det.IdDefinicionAnulacion = @IdDefinicionAnulacion)
ORDER BY Det.Administradores DESC,  Empleados.Nombre, 
		Cargos.Descripcion, Sectores.Descripcion


