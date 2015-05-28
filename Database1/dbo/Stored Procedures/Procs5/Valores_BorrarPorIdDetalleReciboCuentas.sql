















CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleReciboCuentas]
@IdDetalleReciboCuentas int
AS 
DELETE FROM Valores
WHERE (IdDetalleReciboCuentas=@IdDetalleReciboCuentas)
















