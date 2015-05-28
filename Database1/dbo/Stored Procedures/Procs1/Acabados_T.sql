CREATE Procedure [dbo].[Acabados_T]

@IdAcabado int

AS 

SELECT *
FROM Acabados
WHERE (IdAcabado=@IdAcabado)