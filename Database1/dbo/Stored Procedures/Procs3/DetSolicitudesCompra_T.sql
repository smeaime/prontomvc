CREATE Procedure [dbo].[DetSolicitudesCompra_T]

@IdDetalleSolicitudCompra int

AS 

SELECT *
FROM [DetalleSolicitudesCompra]
WHERE (IdDetalleSolicitudCompra=@IdDetalleSolicitudCompra)