CREATE Procedure [dbo].[Acabados_TX_TT]

@IdAcabado int

AS 

SELECT *
FROM Acabados
WHERE (IdAcabado=@IdAcabado)