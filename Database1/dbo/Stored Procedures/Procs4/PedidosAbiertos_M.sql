




CREATE  Procedure [dbo].[PedidosAbiertos_M]
@IdPedidoAbierto int ,
@NumeroPedidoAbierto int,
@FechaPedidoAbierto datetime,
@IdProveedor int,
@FechaLimite datetime,
@ImporteLimite numeric(18,2)
AS
UPDATE PedidosAbiertos
SET
 NumeroPedidoAbierto=@NumeroPedidoAbierto,
 FechaPedidoAbierto=@FechaPedidoAbierto,
 IdProveedor=@IdProveedor,
 FechaLimite=@FechaLimite,
 ImporteLimite=@ImporteLimite
WHERE (IdPedidoAbierto=@IdPedidoAbierto)
RETURN(@IdPedidoAbierto)




