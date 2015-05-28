

CREATE Procedure ProduccionOrdenes_TX_TienePartesAbiertosAsociados
@IdProduccionOrden int
AS 
SELECT * 
FROM ProduccionPartes
WHERE (IdProduccionOrden=@IdProduccionOrden)
AND
IdUsuarioCerro is null
and
isnull(Anulada,'NO')='NO'

