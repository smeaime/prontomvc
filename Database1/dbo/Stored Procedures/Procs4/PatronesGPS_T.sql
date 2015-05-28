
CREATE Procedure [dbo].[PatronesGPS_T]

@IdPatronGPS int

AS 

SELECT * 
FROM PatronesGPS
WHERE (IdPatronGPS=@IdPatronGPS)
