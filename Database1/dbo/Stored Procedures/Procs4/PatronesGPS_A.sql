
CREATE Procedure [dbo].[PatronesGPS_A]

@IdPatronGPS int output,
@Descripcion varchar(50),
@Activa varchar(2)

AS 

INSERT INTO PatronesGPS
(
 Descripcion,
 Activa
)
VALUES 
(
 @Descripcion,
 @Activa
)

SELECT @IdPatronGPS=@@identity
RETURN(@IdPatronGPS)
