




CREATE  Procedure [dbo].[Remitos_TX_PorId]

@IdRemito int

AS 

SELECT 
 Remitos.*
FROM Remitos
WHERE (IdRemito=@IdRemito)




