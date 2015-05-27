
CREATE PROCEDURE [dbo].[DetOrdenesPagoValores_TX_Control]

@IdOrdenPago int,
@IdBancoChequera int,
@NumeroValor numeric(12,0)

AS

SELECT  OrdenesPago.NumeroOrdenPago as [Numero]
FROM DetalleOrdenesPagoValores DetOP
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
WHERE DetOP.IdOrdenPago<>@IdOrdenPago and 
	DetOP.IdBancoChequera=@IdBancoChequera and 
	DetOP.NumeroValor=@NumeroValor and 
	IsNull(OrdenesPago.Anulada,'NO')<>'SI'
