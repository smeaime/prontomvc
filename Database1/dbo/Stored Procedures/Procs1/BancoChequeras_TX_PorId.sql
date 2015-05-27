




























CREATE Procedure [dbo].[BancoChequeras_TX_PorId]
@IdBancoChequera int
AS 
SELECT *
FROM BancoChequeras 
WHERE BancoChequeras.IdBancoChequera=@IdBancoChequera





























