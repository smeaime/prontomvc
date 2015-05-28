CREATE PROCEDURE [dbo].[OrdenesCompra_MarcarComoCumplidas]

@IdOrdenCompra int,
@Marca varchar(2)

AS 

UPDATE DetalleOrdenesCompra
SET Cumplido=@Marca
WHERE IdOrdenCompra=@IdOrdenCompra