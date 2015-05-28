
CREATE Procedure [dbo].[AjustesStock_T]

@IdAjusteStock int

AS 

SELECT * 
FROM AjustesStock
WHERE (IdAjusteStock=@IdAjusteStock)
