



















CREATE Procedure [dbo].[OrdenesPago_TX_PorNumero]
@NumeroOrdenPago int
AS 
SELECT TOP 1 *
FROM OrdenesPago
WHERE NumeroOrdenPago=@NumeroOrdenPago



















