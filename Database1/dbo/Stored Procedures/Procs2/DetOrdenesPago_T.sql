
CREATE Procedure [dbo].[DetOrdenesPago_T]

@IdDetalleOrdenPago int

AS 

SELECT *
FROM DetalleOrdenesPago
WHERE (IdDetalleOrdenPago=@IdDetalleOrdenPago)
