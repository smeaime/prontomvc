




CREATE Procedure ProduccionOrdenes_TX_PorIdOrigen
@IdOrigenTransmision int
AS 
SELECT Top 1 IdProduccionOrden
FROM ProduccionOrdenes
--WHERE = and IdOrigenTransmision=@IdOrigenTransmision

