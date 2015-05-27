CREATE Procedure DetProduccionOrdenesProcesos_TX_PorIdConDatos

@IdProduccionOrden int

AS 

SELECT 
det. *,
Articulos.Descripcion as Maquina,
ProduccionProcesos.Descripcion as Proceso
FROM DetalleProduccionOrdenProcesos Det
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=Det.IdMaquina
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
WHERE IdProduccionOrden=@IdProduccionOrden
