CREATE Procedure [dbo].[OrdenesPago_TX_PorNumeroFF]

@NumeroOrdenPago int

AS 

SELECT TOP 1 *
FROM OrdenesPago op
WHERE op.NumeroOrdenPago=@NumeroOrdenPago and 
	(op.Tipo is not null and op.Tipo='FF') and 
	(op.Anulada is null or op.Anulada<>'SI')