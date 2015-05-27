




CREATE Procedure [dbo].[OrdenesCompra_T]
@IdOrdenCompra int
AS 
SELECT * 
FROM OrdenesCompra
WHERE (IdOrdenCompra=@IdOrdenCompra)




