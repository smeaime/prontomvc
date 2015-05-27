




CREATE Procedure ProduccionFichas_TX_PorIdOrigen
@IdOrigenTransmision int
AS 
SELECT Top 1 IdProduccionFicha
FROM ProduccionFichas
--WHERE = and IdOrigenTransmision=@IdOrigenTransmision


