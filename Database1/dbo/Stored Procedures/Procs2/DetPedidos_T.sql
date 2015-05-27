
CREATE Procedure [dbo].[DetPedidos_T]
@IdDetallePedido int
AS 
SELECT *
FROM [DetallePedidos]
WHERE (IdDetallePedido=@IdDetallePedido)
