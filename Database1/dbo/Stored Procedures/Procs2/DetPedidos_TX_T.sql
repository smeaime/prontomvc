





























CREATE Procedure [dbo].[DetPedidos_TX_T]
@IdDetallePedido int
AS 
SELECT *
FROM [DetallePedidos]
where (IdDetallePedido=@IdDetallePedido)






























