
CREATE Procedure [dbo].[DetOrdenesPagoCuentas_E]
@IdDetalleOrdenPagoCuentas int
AS 
DELETE DetalleOrdenesPagoCuentas
WHERE (IdDetalleOrdenPagoCuentas=@IdDetalleOrdenPagoCuentas)
