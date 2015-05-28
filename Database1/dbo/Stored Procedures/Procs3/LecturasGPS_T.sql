
CREATE Procedure [dbo].[LecturasGPS_T]

@IdLecturaGPS int

AS 

SELECT *
FROM [LecturasGPS]
WHERE (IdLecturaGPS=@IdLecturaGPS)
