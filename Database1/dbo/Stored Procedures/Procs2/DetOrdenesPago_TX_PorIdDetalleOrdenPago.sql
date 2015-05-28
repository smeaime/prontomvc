
CREATE Procedure [dbo].[DetOrdenesPago_TX_PorIdDetalleOrdenPago]

@IdDetalleOrdenPago int

AS 

SELECT *
FROM DetalleOrdenesPago
WHERE IdDetalleOrdenPago=@IdDetalleOrdenPago
