
CREATE Procedure [dbo].[DetAjustesStock_E]

@IdDetalleAjusteStock int  

AS 

DELETE [DetalleAjustesStock]
WHERE (IdDetalleAjusteStock=@IdDetalleAjusteStock)
