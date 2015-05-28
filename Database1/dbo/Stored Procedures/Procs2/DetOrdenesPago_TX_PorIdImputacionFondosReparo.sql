
CREATE Procedure [dbo].[DetOrdenesPago_TX_PorIdImputacionFondosReparo]

@IdImputacion int,
@IdDetalleOrdenPago int

AS 

SELECT *
FROM DetalleOrdenesPago
LEFT OUTER JOIN OrdenesPago ON DetalleOrdenesPago.IdOrdenPago=OrdenesPago.IdOrdenPago
WHERE DetalleOrdenesPago.IdDetalleOrdenPago<>@IdDetalleOrdenPago and DetalleOrdenesPago.IdImputacion=@IdImputacion and 
		IsNull(OrdenesPago.Anulada,'NO')<>'SI' and IsNull(DetalleOrdenesPago.SaldoAFondoDeReparo,0)>0
