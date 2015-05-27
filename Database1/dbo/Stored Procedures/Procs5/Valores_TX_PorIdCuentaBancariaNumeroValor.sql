
CREATE Procedure [dbo].[Valores_TX_PorIdCuentaBancariaNumeroValor]

@NumeroOrdenPago int,
@IdCuentaBancaria int,
@NumeroValor numeric(18)

AS 

SELECT TOP 1 Valores.*
FROM Valores
LEFT OUTER JOIN DetalleOrdenesPagoValores DetOP ON DetOP.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
WHERE Valores.NumeroComprobante<>@NumeroOrdenPago and 
	Valores.IdCuentaBancaria=@IdCuentaBancaria and 
	Valores.NumeroValor=@NumeroValor and 
	IsNull(OrdenesPago.Anulada,'NO')<>'SI'
