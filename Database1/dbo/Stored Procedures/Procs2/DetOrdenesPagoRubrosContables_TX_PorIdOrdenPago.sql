





CREATE PROCEDURE [dbo].[DetOrdenesPagoRubrosContables_TX_PorIdOrdenPago]
@IdOrdenPago int
AS
SELECT *
FROM DetalleOrdenesPagoRubrosContables 
WHERE (DetalleOrdenesPagoRubrosContables.IdOrdenPago = @IdOrdenPago)






