





















CREATE Procedure [dbo].[DetRecibos_TX_PorIdRecibo]
@IdRecibo int
AS 
SELECT *
FROM DetalleRecibos
WHERE (IdRecibo=@IdRecibo)






















