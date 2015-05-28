
CREATE Procedure [dbo].[DetPatronesGPS_E]

@IdDetallePatronGPS int  

AS 

DELETE [DetallePatronesGPS]
WHERE (IdDetallePatronGPS=@IdDetallePatronGPS)
