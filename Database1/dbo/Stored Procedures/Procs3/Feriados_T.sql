CREATE Procedure [dbo].[Feriados_T]

@IdFeriado int

AS 

SELECT *
FROM Feriados
WHERE (IdFeriado=@IdFeriado)