CREATE Procedure [dbo].[DetEmpleadosSectores_M]

@IdDetalleEmpleadoSector int,
@IdEmpleado int,
@FechaCambio Datetime,
@IdSectorNuevo int

AS

UPDATE [DetalleEmpleadosSectores]
SET 
 IdEmpleado=@IdEmpleado,
 FechaCambio=@FechaCambio,
 IdSectorNuevo=@IdSectorNuevo
WHERE (IdDetalleEmpleadoSector=@IdDetalleEmpleadoSector)

RETURN(@IdDetalleEmpleadoSector)