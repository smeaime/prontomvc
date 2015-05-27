CREATE Procedure DetProduccionFichaProcesos_TX_PorIdConDatos

@IdProduccionFicha int

AS 

SELECT 
det. *,
ProduccionProcesos.Descripcion as Proceso
FROM DetalleProduccionFichaProcesos Det
--LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=Det.IdMaquina
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
WHERE IdProduccionFicha=@IdProduccionFicha
