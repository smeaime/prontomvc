
CREATE Procedure [dbo].[DetOrdenesPagoCuentas_T]
@IdDetalleOrdenPagoCuentas int
AS 
SELECT *
FROM DetalleOrdenesPagoCuentas
WHERE (IdDetalleOrdenPagoCuentas=@IdDetalleOrdenPagoCuentas)
