



CREATE Procedure [dbo].[DepositosBancarios_TX_PorId]
@IdDepositoBancario int
AS 
SELECT *
FROM DepositosBancarios
WHERE (IdDepositoBancario=@IdDepositoBancario)



