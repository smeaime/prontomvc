
CREATE Procedure [dbo].[FletesPartesDiarios_T]

@IdFleteParteDiario int

AS 

SELECT *
FROM FletesPartesDiarios
WHERE (IdFleteParteDiario=@IdFleteParteDiario)
