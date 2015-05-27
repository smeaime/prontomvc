





CREATE PROCEDURE [dbo].[DetRecibosRubrosContables_TX_PorIdRecibo]
@IdRecibo int
AS
SELECT *
FROM DetalleRecibosRubrosContables 
WHERE (DetalleRecibosRubrosContables.IdRecibo = @IdRecibo)






