

























CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleOrdenPagoCuentas]
@IdDetalleOrdenPagoCuentas int
AS 
DELETE FROM Valores
WHERE (IdDetalleOrdenPagoCuentas=@IdDetalleOrdenPagoCuentas)


























