CREATE PROCEDURE [dbo].[DetSolicitudesCompra_TX_Datos]

@IdSolicitudCompra int

AS

SELECT
 DetSol.IdDetalleSolicitudCompra,
 DetSol.Cantidad as [CantSol],
 DetalleRequerimientos.*,
 Requerimientos.NumeroRequerimiento,
 Requerimientos.IdComprador
FROM DetalleSolicitudesCompra DetSol
LEFT OUTER JOIN SolicitudesCompra ON DetSol.IdSolicitudCompra = SolicitudesCompra.IdSolicitudCompra
LEFT OUTER JOIN DetalleRequerimientos ON DetSol.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (DetSol.IdSolicitudCompra = @IdSolicitudCompra)
ORDER by DetalleRequerimientos.NumeroItem