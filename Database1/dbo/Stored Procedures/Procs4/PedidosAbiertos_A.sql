




CREATE Procedure [dbo].[PedidosAbiertos_A]
@IdPedidoAbierto int  output,
@NumeroPedidoAbierto int,
@FechaPedidoAbierto datetime,
@IdProveedor int,
@FechaLimite datetime,
@ImporteLimite numeric(18,2)
AS 
Insert into [PedidosAbiertos]
(
 NumeroPedidoAbierto,
 FechaPedidoAbierto,
 IdProveedor,
 FechaLimite,
 ImporteLimite
)
Values
(
 @NumeroPedidoAbierto,
 @FechaPedidoAbierto,
 @IdProveedor,
 @FechaLimite,
 @ImporteLimite
)
Select @IdPedidoAbierto=@@identity
Return(@IdPedidoAbierto)




