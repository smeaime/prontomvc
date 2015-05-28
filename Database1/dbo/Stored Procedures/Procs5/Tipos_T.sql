CREATE Procedure [dbo].[Tipos_T]

@IdTipo int

AS 

SELECT *
FROM Tipos
WHERE (IdTipo=@IdTipo)