



CREATE Procedure [dbo].[Recepciones_T]
@IdRecepcion int
AS 
SELECT * 
FROM Recepciones
WHERE (IdRecepcion=@IdRecepcion)



