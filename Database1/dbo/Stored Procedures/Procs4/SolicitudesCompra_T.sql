



CREATE Procedure [dbo].[SolicitudesCompra_T]
@IdSolicitudCompra int
AS 
SELECT * 
FROM SolicitudesCompra
WHERE (IdSolicitudCompra=@IdSolicitudCompra)



