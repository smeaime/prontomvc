







CREATE Procedure [dbo].[HorasJornadas_A]
@IdHorasJornada int  output,
@IdEmpleado int,
@FechaJornada datetime,
@HorasJornada numeric(9,2)
AS 
Insert into [HorasJornadas]
(
IdEmpleado,
FechaJornada,
HorasJornada
)
Values
(
@IdEmpleado,
@FechaJornada,
@HorasJornada
)
Select @IdHorasJornada=@@identity
Return(@IdHorasJornada)









