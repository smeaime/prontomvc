






























CREATE Procedure [dbo].[Requerimientos_TX_PorIdOrigenDetalle]
@IdDetalleRequerimientoOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 drm.IdDetalleRequerimiento,Requerimientos.IdRequerimiento
FROM DetalleRequerimientos drm
LEFT OUTER JOIN Requerimientos ON drm.IdRequerimiento=Requerimientos.IdRequerimiento
WHERE 	drm.IdDetalleRequerimientoOriginal=@IdDetalleRequerimientoOriginal and 
	drm.IdOrigenTransmision=@IdOrigenTransmision































