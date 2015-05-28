
CREATE Procedure [dbo].[MovimientosFletes_Actualizar]

@IdMovimientoFlete int,
@IdFlete int,
@Fecha datetime,
@Tipo varchar(1),
@Touch varchar(5),
@IdDispositivoGPS int,
@FechaLecturaArchivoMovimiento datetime

AS 

IF @IdMovimientoFlete<=0
	SET @IdMovimientoFlete=IsNull((Select Top 1 IdMovimientoFlete From MovimientosFletes
					Where IdFlete=@IdFlete and Fecha=@Fecha and IdDispositivoGPS=@IdDispositivoGPS),0)

IF @IdMovimientoFlete<=0
    BEGIN
	INSERT INTO MovimientosFletes
	(IdFlete, Fecha, Tipo, Touch, IdDispositivoGPS, FechaLecturaArchivoMovimiento)
	VALUES
	(@IdFlete, @Fecha, @Tipo, @Touch, @IdDispositivoGPS, @FechaLecturaArchivoMovimiento)
	SELECT @IdMovimientoFlete=@@identity
    END
ELSE
    BEGIN
	UPDATE MovimientosFletes
	SET
	 IdFlete=@IdFlete,
	 Fecha=@Fecha,
	 Tipo=@Tipo,
	 Touch=@Touch,
	 IdDispositivoGPS=@IdDispositivoGPS,
	 FechaLecturaArchivoMovimiento=@FechaLecturaArchivoMovimiento
	WHERE IdMovimientoFlete=@IdMovimientoFlete
    END

RETURN(@IdMovimientoFlete)
