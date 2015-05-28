
CREATE Procedure [dbo].[AjustesStock_TX_PorMarbete]

@NumeroMarbete int

AS 

SELECT * 
FROM AjustesStock
WHERE NumeroMarbete=@NumeroMarbete
