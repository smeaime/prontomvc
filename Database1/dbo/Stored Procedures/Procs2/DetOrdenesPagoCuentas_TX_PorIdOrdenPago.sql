
CREATE PROCEDURE [dbo].[DetOrdenesPagoCuentas_TX_PorIdOrdenPago]
@IdOrdenPago int
AS
SELECT *
FROM DetalleOrdenesPagoCuentas 
WHERE (DetalleOrdenesPagoCuentas.IdOrdenPago = @IdOrdenPago)
