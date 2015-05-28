
CREATE Procedure [dbo].[Recepciones_TX_PorId]

@IdRecepcion int

AS 

SELECT * 
FROM Recepciones
WHERE (IdRecepcion=@IdRecepcion)
