
CREATE Procedure [dbo].[PatronesGPS_E]

@IdPatronGPS int  

AS 

DELETE PatronesGPS
WHERE (IdPatronGPS=@IdPatronGPS)
