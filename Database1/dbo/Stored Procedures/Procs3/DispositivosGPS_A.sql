
CREATE Procedure [dbo].[DispositivosGPS_A]

@IdDispositivoGPS int  output,
@Descripcion varchar(50),
@Destino varchar(1)

AS 

INSERT INTO [DispositivosGPS]
(
 Descripcion,
 Destino
)
VALUES
(
 @Descripcion,
 @Destino
)

SELECT @IdDispositivoGPS=@@identity
RETURN(@IdDispositivoGPS)
