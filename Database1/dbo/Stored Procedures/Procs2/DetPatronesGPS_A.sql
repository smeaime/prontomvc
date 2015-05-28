
CREATE Procedure [dbo].[DetPatronesGPS_A]

@IdDetallePatronGPS int  output,
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

INSERT INTO [DetallePatronesGPS]
(
 IdPatronGPS,
 Latitud,
 Longitud,
 Altura,
 DistanciaKm,
 Temperatura,
 Velocidad,
 Curso,
 FechaLectura,
 NumeroRegistro
)
VALUES 
(
 @IdPatronGPS,
 @Latitud,
 @Longitud,
 @Altura,
 @DistanciaKm,
 @Temperatura,
 @Velocidad,
 @Curso,
 @FechaLectura,
 @NumeroRegistro
)

SELECT @IdDetallePatronGPS=@@identity
RETURN(@IdDetallePatronGPS)
