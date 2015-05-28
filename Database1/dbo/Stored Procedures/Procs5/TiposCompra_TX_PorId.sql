
CREATE Procedure [dbo].[TiposCompra_TX_PorId]
@IdTipoCompra int
AS 
SELECT *
FROM TiposCompra 
WHERE IdTipoCompra=@IdTipoCompra
