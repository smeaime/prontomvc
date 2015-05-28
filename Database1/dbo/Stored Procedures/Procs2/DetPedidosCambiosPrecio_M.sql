CREATE Procedure [dbo].[DetPedidosCambiosPrecio_M]

@IdDetallePedidoCambioPrecio int,
@IdDetallePedido int,
@Fecha datetime,
@IdUsuario int,
@Observaciones ntext,
@PrecioAnterior numeric(18,2),
@PrecioNuevo numeric(18,2)

AS

UPDATE [DetallePedidosCambiosPrecio]
SET 
 IdDetallePedido=@IdDetallePedido,
 Fecha=@Fecha,
 IdUsuario=@IdUsuario,
 Observaciones=@Observaciones,
 PrecioAnterior=@PrecioAnterior,
 PrecioNuevo=@PrecioNuevo
WHERE (IdDetallePedidoCambioPrecio=@IdDetallePedidoCambioPrecio)

RETURN(@IdDetallePedidoCambioPrecio)