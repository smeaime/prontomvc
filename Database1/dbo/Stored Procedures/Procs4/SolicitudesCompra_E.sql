



CREATE Procedure [dbo].[SolicitudesCompra_E]
@IdSolicitudCompra int  
AS 
DELETE SolicitudesCompra
WHERE (IdSolicitudCompra=@IdSolicitudCompra)



