





























CREATE Procedure [dbo].[DetEmpleados_A]
@IdDetalleEmpleado int  output,
@IdEmpleado int,
@FechaIngreso Datetime,
@FechaEgreso Datetime
AS 
Insert into [DetalleEmpleados]
(
 IdEmpleado,
 FechaIngreso,
 FechaEgreso
)
Values
(
 @IdEmpleado,
 @FechaIngreso,
 @FechaEgreso
)
Select @IdDetalleEmpleado=@@identity
Return(@IdDetalleEmpleado)






























