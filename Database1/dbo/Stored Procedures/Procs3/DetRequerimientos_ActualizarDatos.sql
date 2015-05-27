CREATE Procedure [dbo].[DetRequerimientos_ActualizarDatos]

@IdDetalleRequerimiento int,
@ObservacionesFirmante ntext,
@IdFirmanteObservo int,
@FechaUltimaObservacionFirmante datetime

AS 

UPDATE [DetalleRequerimientos]
SET 
 ObservacionesFirmante=@ObservacionesFirmante,
 IdFirmanteObservo=@IdFirmanteObservo,
 FechaUltimaObservacionFirmante=@FechaUltimaObservacionFirmante
WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)