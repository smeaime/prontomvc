
CREATE Procedure [dbo].[MovimientosFletes_A]

@IdMovimientoFlete int  output,
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

INSERT INTO [MovimientosFletes]
(
 IdFlete,
 Fecha,
 Tipo,
 Touch,
 IdDispositivoGPS, 
 IdLecturaGPS, 
 DistanciaRecorridaKm, 
 IdPatronGPS, 
 ModalidadFacturacion, 
 ValorUnitario,
 FechaUltimaModificacionManual,
 FechaLecturaArchivoMovimiento
)
VALUES
(
 @IdFlete,
 @Fecha,
 @Tipo,
 @Touch,
 @IdDispositivoGPS, 
 @IdLecturaGPS, 
 @DistanciaRecorridaKm, 
 @IdPatronGPS, 
 @ModalidadFacturacion, 
 @ValorUnitario,
 @FechaUltimaModificacionManual,
 @FechaLecturaArchivoMovimiento
)

SELECT @IdMovimientoFlete=@@identity
RETURN(@IdMovimientoFlete)
