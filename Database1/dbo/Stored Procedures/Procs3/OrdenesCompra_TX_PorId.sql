




CREATE Procedure [dbo].[OrdenesCompra_TX_PorId]
@IdOrdenCompra int
AS 
SELECT * 
FROM OrdenesCompra
WHERE (IdOrdenCompra=@IdOrdenCompra)




