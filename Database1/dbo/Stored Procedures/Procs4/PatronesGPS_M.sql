
CREATE Procedure [dbo].[PatronesGPS_M]

@IdPatronGPS int,
@Descripcion varchar(50),
@Activa varchar(2)

AS

UPDATE PatronesGPS
SET
 Descripcion=@Descripcion,
 Activa=@Activa
WHERE (IdPatronGPS=@IdPatronGPS)

RETURN(@IdPatronGPS)
