
CREATE Procedure [dbo].[DetOrdenesPago_TX_PorIdImputacionOtrasOP]

@IdOrdenPago int,
@IdImputacion int

AS 

SELECT *
FROM DetalleOrdenesPago
LEFT OUTER JOIN OrdenesPago ON DetalleOrdenesPago.IdOrdenPago=OrdenesPago.IdOrdenPago
WHERE DetalleOrdenesPago.IdOrdenPago<>@IdOrdenPago and 
	DetalleOrdenesPago.IdImputacion=@IdImputacion and 
	IsNull(OrdenesPago.Anulada,'NO')<>'SI'
