
CREATE Procedure [dbo].[DetAjustesStockSAT_T]
@IdDetalleAjusteStock int
AS 
SELECT *
FROM [DetalleAjustesStockSAT]
WHERE (IdDetalleAjusteStock=@IdDetalleAjusteStock)
