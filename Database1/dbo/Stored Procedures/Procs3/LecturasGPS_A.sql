
CREATE Procedure [dbo].[LecturasGPS_A]

@IdLecturaGPS int  output,
@Latitud numeric(18,8),
@Longitud numeric(18,8),
@Altura numeric(18,8),
@Temperatura numeric(6,2),
@Velocidad varchar(15),
@Curso varchar(2),
@FechaLectura datetime,
@NumeroRegistro int,
@IdDispositivoGPS int

AS 

INSERT INTO [LecturasGPS]
(
 Latitud,
 Longitud,
 Altura,
 Temperatura,
 Velocidad,
 Curso,
 FechaLectura,
 NumeroRegistro,
 IdDispositivoGPS
)
VALUES 
(
 @Latitud,
 @Longitud,
 @Altura,
 @Temperatura,
 @Velocidad,
 @Curso,
 @FechaLectura,
 @NumeroRegistro,
 @IdDispositivoGPS
)

SELECT @IdLecturaGPS=@@identity
RETURN(@IdLecturaGPS)
