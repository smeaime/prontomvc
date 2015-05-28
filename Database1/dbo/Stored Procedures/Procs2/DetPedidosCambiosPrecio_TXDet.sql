CREATE PROCEDURE [dbo].[DetPedidosCambiosPrecio_TXDet]

@IdDetallePedido int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111133'
SET @vector_T='08444400'

SELECT
 Det.IdDetallePedidoCambioPrecio,
 Det.Fecha as [Fecha],
 Det.PrecioAnterior as [Precio anterior],
 Det.PrecioNuevo as [Precio nuevo],
 Empleados.Nombre as [Usuario],
 Det.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidosCambiosPrecio Det
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = Det.IdUsuario
WHERE (Det.IdDetallePedido = @IdDetallePedido)