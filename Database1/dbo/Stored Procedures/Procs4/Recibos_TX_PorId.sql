CREATE Procedure [dbo].[Recibos_TX_PorId]

@IdRecibo int

AS 

SELECT *
FROM Recibos
WHERE (IdRecibo=@IdRecibo)