CREATE Procedure [dbo].[Feriados_TX_TT]

@IdFeriado int

AS 

SELECT *
FROM Feriados
WHERE (IdFeriado=@IdFeriado)