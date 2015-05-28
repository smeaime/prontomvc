
CREATE Procedure [dbo].[DetAjustesStock_T]

@IdDetalleAjusteStock int

AS 

SELECT *
FROM [DetalleAjustesStock]
WHERE (IdDetalleAjusteStock=@IdDetalleAjusteStock)
