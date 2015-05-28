
CREATE Procedure DetProduccionFichas_TX_Todos

@IdProduccionFicha int

AS 


SELECT 
 *
FROM DetalleProduccionFichas 
WHERE IdProduccionFicha=@IdProduccionFicha

