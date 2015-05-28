CREATE Procedure [dbo].[DetSolicitudesCompra_A]

@IdDetalleSolicitudCompra int  output,
@IdSolicitudCompra int,
@IdDetalleRequerimiento int,
@Cantidad numeric(18,2)

AS 

INSERT INTO [DetalleSolicitudesCompra]
(
 IdSolicitudCompra,
 IdDetalleRequerimiento,
 Cantidad
)
VALUES
(
 @IdSolicitudCompra,
 @IdDetalleRequerimiento,
 @Cantidad
)

SELECT @IdDetalleSolicitudCompra=@@identity

RETURN(@IdDetalleSolicitudCompra)