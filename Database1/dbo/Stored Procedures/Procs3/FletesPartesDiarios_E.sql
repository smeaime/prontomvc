
CREATE Procedure [dbo].[FletesPartesDiarios_E]

@IdFleteParteDiario int 

AS 

DELETE FletesPartesDiarios
WHERE (IdFleteParteDiario=@IdFleteParteDiario)
