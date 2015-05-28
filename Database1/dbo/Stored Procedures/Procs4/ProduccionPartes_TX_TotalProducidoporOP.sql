
CREATE Procedure ProduccionPartes_TX_TotalProducidoporOP
@idProduccionOrden int
AS 

SELECT sum(isnull(CantidadGenerado,0)) as CantidadTotal
FROM ProduccionPartes
WHERE (idProduccionOrden=@idProduccionOrden)
