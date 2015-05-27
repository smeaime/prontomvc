CREATE Procedure [dbo].[Previsiones_T]

@IdPrevision int

AS 

SELECT *
FROM Previsiones
WHERE (IdPrevision=@IdPrevision)