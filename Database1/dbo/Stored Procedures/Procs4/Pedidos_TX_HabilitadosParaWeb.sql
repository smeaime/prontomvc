


CREATE PROCEDURE [dbo].[Pedidos_TX_HabilitadosParaWeb]

@Desde datetime,
@Hasta datetime

AS

SELECT 
 Pedidos.IdPedido,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 Pedidos.FechaPedido [Fecha]
FROM Pedidos
WHERE (Pedidos.Cumplido is null or Pedidos.Cumplido='NO') And 
	(Pedidos.FechaPedido Between @Desde And @Hasta)
ORDER BY NumeroPedido, SubNumero


