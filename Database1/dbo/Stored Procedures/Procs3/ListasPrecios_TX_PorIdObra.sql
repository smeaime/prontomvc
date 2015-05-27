CREATE Procedure [dbo].[ListasPrecios_TX_PorIdObra]

@IdObra int

AS 

SELECT *
FROM ListasPrecios
WHERE (IdObra=@IdObra)