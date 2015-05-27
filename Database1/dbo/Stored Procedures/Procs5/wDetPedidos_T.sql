
CREATE Procedure [dbo].[wDetPedidos_T]

@IdDetallePedido int

AS 

SELECT *
FROM [DetallePedidos]
WHERE (IdDetallePedido=@IdDetallePedido)

