
CREATE Procedure [dbo].[LecturasGPS_E]

@IdLecturaGPS int  

AS 

DELETE [LecturasGPS]
WHERE (IdLecturaGPS=@IdLecturaGPS)
