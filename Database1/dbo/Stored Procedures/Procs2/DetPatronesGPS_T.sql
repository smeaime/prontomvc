
CREATE Procedure [dbo].[DetPatronesGPS_T]

@IdDetallePatronGPS int

AS 

SELECT *
FROM [DetallePatronesGPS]
WHERE (IdDetallePatronGPS=@IdDetallePatronGPS)
