
CREATE Procedure ProduccionOrdenes_T
@IdProduccionOrden int
AS 
SELECT * 
FROM ProduccionOrdenes
WHERE (IdProduccionOrden=@IdProduccionOrden)
