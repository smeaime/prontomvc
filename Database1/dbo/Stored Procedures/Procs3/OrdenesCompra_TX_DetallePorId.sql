


CREATE PROCEDURE [dbo].[OrdenesCompra_TX_DetallePorId]
@IdOrdenCompra int
AS
SELECT * 
FROM DetalleOrdenesCompra 
WHERE IdOrdenCompra=@IdOrdenCompra


