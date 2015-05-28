CREATE Procedure [dbo].[Pedidos_ActualizarDatos]

@IdDetallePedido int,
@FechaEntrega datetime

AS

UPDATE DetallePedidos
SET FechaEntrega=@FechaEntrega
WHERE IdDetallePedido=@IdDetallePedido
