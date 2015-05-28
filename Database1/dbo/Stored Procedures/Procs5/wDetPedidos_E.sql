
CREATE Procedure [dbo].[wDetPedidos_E]

@IdDetallePedido int  

AS 

DELETE [DetallePedidos]
WHERE (IdDetallePedido=@IdDetallePedido)

