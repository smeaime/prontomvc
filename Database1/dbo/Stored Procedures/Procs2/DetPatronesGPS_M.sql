
CREATE Procedure [dbo].[DetPatronesGPS_M]

@IdDetallePatronGPS int,
@IdPatronGPS int,
@Latitud numeric(18,8),
@Longitud numeric(18,8),
@Altura numeric(18,8),
@DistanciaKm numeric(18,8),
@Temperatura numeric(6,2),
@Velocidad varchar(20),
@Curso varchar(2),
@FechaLectura datetime,
@NumeroRegistro int

AS

UPDATE [DetallePatronesGPS]
SET 
 IdPatronGPS=@IdPatronGPS,
 Latitud=@Latitud,
 Longitud=@Longitud,
 Altura=@Altura,
 DistanciaKm=@DistanciaKm,
 Temperatura=@Temperatura,
 Velocidad=@Velocidad,
 Curso=@Curso,
 FechaLectura=@FechaLectura,
 NumeroRegistro=@NumeroRegistro
WHERE (IdDetallePatronGPS=@IdDetallePatronGPS)

RETURN(@IdDetallePatronGPS)
