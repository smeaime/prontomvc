
CREATE  Procedure [dbo].[DispositivosGPS_M]

@IdDispositivoGPS int ,
@Descripcion varchar(50),
@Destino varchar(1)

AS

UPDATE DispositivosGPS
SET
 Descripcion=@Descripcion,
 Destino=@Destino
WHERE (IdDispositivoGPS=@IdDispositivoGPS)

RETURN(@IdDispositivoGPS)
