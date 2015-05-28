CREATE Procedure [dbo].[DetPedidosCambiosPrecio_T]

@IdDetallePedidoCambioPrecio int

AS 

SELECT *
FROM [DetallePedidosCambiosPrecio]
WHERE (IdDetallePedidoCambioPrecio=@IdDetallePedidoCambioPrecio)