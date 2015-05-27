
CREATE Procedure [dbo].[AjustesStockSAT_T]
@IdAjusteStock int
AS 
SELECT * 
FROM AjustesStockSAT
WHERE (IdAjusteStock=@IdAjusteStock)
