CREATE Procedure [dbo].[ListasPrecios_T]

@IdListaPrecios int

AS 

SELECT *
FROM ListasPrecios
WHERE (IdListaPrecios=@IdListaPrecios)