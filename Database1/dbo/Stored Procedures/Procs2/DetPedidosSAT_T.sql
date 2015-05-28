
CREATE Procedure [dbo].[DetPedidosSAT_T]
@IdDetallePedido int
AS 
SELECT *
FROM [DetallePedidosSAT]
where (IdDetallePedido=@IdDetallePedido)
