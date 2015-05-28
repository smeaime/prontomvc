CREATE Procedure [dbo].[DetSolicitudesCompra_M]

@IdDetalleSolicitudCompra int,
@IdSolicitudCompra int,
@IdDetalleRequerimiento int,
@Cantidad numeric(18,2)

AS

UPDATE [DetalleSolicitudesCompra]
SET 
 IdSolicitudCompra=@IdSolicitudCompra,
 IdDetalleRequerimiento=@IdDetalleRequerimiento,
 Cantidad=@Cantidad
WHERE (IdDetalleSolicitudCompra=@IdDetalleSolicitudCompra)

RETURN(@IdDetalleSolicitudCompra)