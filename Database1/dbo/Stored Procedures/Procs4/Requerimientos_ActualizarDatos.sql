CREATE Procedure [dbo].[Requerimientos_ActualizarDatos]

@IdDetalleRequerimiento int,
@FechaEntrega datetime

AS

UPDATE DetalleRequerimientos
SET FechaEntrega=@FechaEntrega
WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento

