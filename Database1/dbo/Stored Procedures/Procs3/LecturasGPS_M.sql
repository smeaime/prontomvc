
CREATE Procedure [dbo].[LecturasGPS_M]

@IdLecturaGPS int,
@Latitud numeric(18,8),
@Longitud numeric(18,8),
@Altura numeric(18,8),
@Temperatura numeric(6,2),
@Velocidad varchar(20),
@Curso varchar(2),
@FechaLectura datetime,
@NumeroRegistro int,
@IdDispositivoGPS int

AS

UPDATE [LecturasGPS]
SET 
 Latitud=@Latitud,
 Longitud=@Longitud,
 Altura=@Altura,
 Temperatura=@Temperatura,
 Velocidad=@Velocidad,
 Curso=@Curso,
 FechaLectura=@FechaLectura,
 NumeroRegistro=@NumeroRegistro,
 IdDispositivoGPS=@IdDispositivoGPS
WHERE (IdLecturaGPS=@IdLecturaGPS)

RETURN(@IdLecturaGPS)
