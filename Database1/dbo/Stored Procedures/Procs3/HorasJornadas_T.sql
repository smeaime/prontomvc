







CREATE Procedure [dbo].[HorasJornadas_T]
@IdHorasJornada int
AS 
SELECT *
FROM HorasJornadas
where (IdHorasJornada=@IdHorasJornada)








