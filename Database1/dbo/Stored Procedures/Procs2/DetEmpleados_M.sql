
CREATE Procedure [dbo].[DetEmpleados_M]

@IdDetalleEmpleado int,
@IdEmpleado int,
@FechaIngreso Datetime,
@FechaEgreso Datetime

AS

UPDATE [DetalleEmpleados]
SET 
 IdEmpleado=@IdEmpleado,
 FechaIngreso=@FechaIngreso,
 FechaEgreso=@FechaEgreso
WHERE (IdDetalleEmpleado=@IdDetalleEmpleado)

RETURN(@IdDetalleEmpleado)
