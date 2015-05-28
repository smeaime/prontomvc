
CREATE PROCEDURE [dbo].[Recepciones_TX_DetallesPorIdRecepcion]

@IdRecepcion int

AS

SELECT *
FROM DetalleRecepciones DetRec
WHERE (DetRec.IdRecepcion = @IdRecepcion)
