
CREATE Procedure DetProduccionFichasProcesos_TX_Todos

@IdProduccionFicha int

AS 


SELECT 
 *
FROM DetalleProduccionFichaProcesos 
WHERE IdProduccionFicha=@IdProduccionFicha

