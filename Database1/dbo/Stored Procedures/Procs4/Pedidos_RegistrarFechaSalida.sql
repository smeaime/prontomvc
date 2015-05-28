


CREATE Procedure [dbo].[Pedidos_RegistrarFechaSalida]
@IdPedido int,
@FechaSalida datetime
AS
UPDATE Pedidos
SET FechaSalida=@FechaSalida
WHERE (IdPedido=@IdPedido)
RETURN(@IdPedido)


