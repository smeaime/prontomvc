

























CREATE Procedure [dbo].[Valores_TX_PorIdDetalleOrdenPagoCuentas]
@IdDetalleOrdenPagoCuentas int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleOrdenPagoCuentas=@IdDetalleOrdenPagoCuentas


























