
CREATE Procedure [dbo].[AjustesStock_E]

@IdAjusteStock int  

AS 

DELETE AjustesStock
WHERE (IdAjusteStock=@IdAjusteStock)
