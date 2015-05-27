
CREATE Procedure [dbo].[OrdenesPago_TX_PorIdDetalleOrdenPago]

@IdDetalleOrdenPago int

AS 

SELECT OrdenesPago.*
FROM DetalleOrdenesPago dop
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dop.IdOrdenPago
WHERE dop.IdDetalleOrdenPago=@IdDetalleOrdenPago and IsNull(OrdenesPago.Anulada,'')<>'SI'
