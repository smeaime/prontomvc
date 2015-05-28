

CREATE Procedure ProduccionPartes_TX_PorIdOrden
@IdProduccionOrden int
AS 
SELECT * 
FROM ProduccionPartes
WHERE (IdProduccionOrden=@IdProduccionOrden)
