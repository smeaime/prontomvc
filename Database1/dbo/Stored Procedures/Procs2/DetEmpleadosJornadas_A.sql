





CREATE Procedure [dbo].[DetEmpleadosJornadas_A]

@IdDetalleEmpleadoJornada int  output,
@IdEmpleado int,
@FechaCambio Datetime,
@HorasJornada numeric(6,2)
AS 
Insert into [DetalleEmpleadosJornadas]
(
 IdEmpleado,
 FechaCambio,
 HorasJornada
)
Values
(
 @IdEmpleado,
 @FechaCambio,
 @HorasJornada
)
Select @IdDetalleEmpleadoJornada=@@identity
Return(@IdDetalleEmpleadoJornada)






