


CREATE Procedure [dbo].[Recepciones_E]
@IdRecepcion int  AS 
DELETE Recepciones
WHERE (IdRecepcion=@IdRecepcion)


