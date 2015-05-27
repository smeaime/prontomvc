CREATE Procedure [dbo].[DetSolicitudesCompra_E]

@IdDetalleSolicitudCompra int  

AS 

DELETE [DetalleSolicitudesCompra]
WHERE (IdDetalleSolicitudCompra=@IdDetalleSolicitudCompra)