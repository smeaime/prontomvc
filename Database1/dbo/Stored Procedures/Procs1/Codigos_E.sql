
CREATE Procedure [dbo].[Codigos_E]

@IdCodigo int  

AS 

DELETE Codigos
WHERE (IdCodigo=@IdCodigo)
