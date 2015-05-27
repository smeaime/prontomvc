










CREATE Procedure [dbo].[Asientos_TX_PorNumero]
@NumeroAsiento int
AS 
SELECT *
FROM Asientos
WHERE NumeroAsiento=@NumeroAsiento










