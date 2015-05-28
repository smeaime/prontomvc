







CREATE  Procedure [dbo].[HorasJornadas_M]
@IdHorasJornada int,
@IdEmpleado int,
@FechaJornada datetime,
@HorasJornada numeric(9,2)
AS
Update HorasJornadas
SET
IdEmpleado=@IdEmpleado,
FechaJornada=@FechaJornada,
HorasJornada=@HorasJornada
where (IdHorasJornada=@IdHorasJornada)
Return(@IdHorasJornada)









