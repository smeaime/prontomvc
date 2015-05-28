




CREATE Procedure [dbo].[OrdenesPago_TX_PorNumeroIdObraOrigen]
@NumeroOrdenPago int,
@IdObraOrigen int
AS 
SELECT TOP 1 *
FROM OrdenesPago
WHERE NumeroOrdenPago=@NumeroOrdenPago and IdObraOrigen=@IdObraOrigen





