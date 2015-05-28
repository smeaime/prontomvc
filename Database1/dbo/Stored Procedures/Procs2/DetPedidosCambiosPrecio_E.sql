CREATE Procedure [dbo].[DetPedidosCambiosPrecio_E]

@IdDetallePedidoCambioPrecio int  

AS

DELETE [DetallePedidosCambiosPrecio]
WHERE (IdDetallePedidoCambioPrecio=@IdDetallePedidoCambioPrecio)