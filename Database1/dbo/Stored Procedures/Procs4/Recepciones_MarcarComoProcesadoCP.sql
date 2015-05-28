
CREATE Procedure [dbo].[Recepciones_MarcarComoProcesadoCP]

@IdRecepcion int

AS 

UPDATE Recepciones
SET ProcesadoPorCPManualmente="SI"
WHERE (IdRecepcion=@IdRecepcion)
