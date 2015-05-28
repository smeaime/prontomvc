
CREATE Procedure [dbo].[Pedidos_TX_DetallesPorId]

@IdPedido int, 
@NumeroItem int = Null

AS 

SET @NumeroItem=IsNull(@NumeroItem,-1)

SELECT *
FROM [DetallePedidos]
WHERE IdPedido=@IdPedido and (@NumeroItem=-1 or NumeroItem=@NumeroItem)
