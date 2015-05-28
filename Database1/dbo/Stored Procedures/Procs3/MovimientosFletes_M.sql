
CREATE  Procedure [dbo].[MovimientosFletes_M]

@IdMovimientoFlete int ,
@IdFlete int,
@Fecha datetime,
@Tipo varchar(1),
@Touch varchar(5),
@IdDispositivoGPS int, 
@IdLecturaGPS int, 
@DistanciaRecorridaKm numeric(18,8), 
@IdPatronGPS int, 
@ModalidadFacturacion tinyint, 
@ValorUnitario numeric(18,2),
@FechaUltimaModificacionManual datetime,
@FechaLecturaArchivoMovimiento datetime

AS

UPDATE MovimientosFletes
SET
 IdFlete=@IdFlete,
 Fecha=@Fecha,
 Tipo=@Tipo,
 Touch=@Touch,
 IdDispositivoGPS=@IdDispositivoGPS,
 IdLecturaGPS=@IdLecturaGPS,
 DistanciaRecorridaKm=@DistanciaRecorridaKm,
 IdPatronGPS=@IdPatronGPS,
 ModalidadFacturacion=@ModalidadFacturacion,
 ValorUnitario=@ValorUnitario,
 FechaUltimaModificacionManual=@FechaUltimaModificacionManual,
 FechaLecturaArchivoMovimiento=@FechaLecturaArchivoMovimiento
WHERE (IdMovimientoFlete=@IdMovimientoFlete)

RETURN(@IdMovimientoFlete)
