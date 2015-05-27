CREATE Procedure [dbo].[ProduccionOrdenes_TX_PorNumeroOrdenProduccion]

@NumeroOrdenProduccion int

AS 

SELECT * 
FROM ProduccionOrdenes
WHERE NumeroOrdenProduccion=@NumeroOrdenProduccion