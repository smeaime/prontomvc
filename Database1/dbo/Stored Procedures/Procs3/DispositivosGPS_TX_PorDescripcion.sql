
CREATE Procedure [dbo].[DispositivosGPS_TX_PorDescripcion]

@Descripcion varchar(50),
@IdDispositivoGPS int = Null

AS 

SET @IdDispositivoGPS=IsNull(@IdDispositivoGPS,-1)

SELECT * 
FROM DispositivosGPS
WHERE (@IdDispositivoGPS=-1 or IdDispositivoGPS<>@IdDispositivoGPS) and Descripcion=@Descripcion
