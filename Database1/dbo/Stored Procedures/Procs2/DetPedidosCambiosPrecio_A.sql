CREATE Procedure [dbo].[DetPedidosCambiosPrecio_A]

@IdDetallePedidoCambioPrecio int  output,
@IdDetallePedido int,
@Fecha datetime,
@IdUsuario int,
@Observaciones ntext,
@PrecioAnterior numeric(18,2),
@PrecioNuevo numeric(18,2)

AS

INSERT INTO [DetallePedidosCambiosPrecio]
(
 IdDetallePedido,
 Fecha,
 IdUsuario,
 Observaciones,
 PrecioAnterior,
 PrecioNuevo
)
VALUES
(
 @IdDetallePedido,
 @Fecha,
 @IdUsuario,
 @Observaciones,
 @PrecioAnterior,
 @PrecioNuevo
)

SELECT @IdDetallePedidoCambioPrecio=@@identity

RETURN(@IdDetallePedidoCambioPrecio)