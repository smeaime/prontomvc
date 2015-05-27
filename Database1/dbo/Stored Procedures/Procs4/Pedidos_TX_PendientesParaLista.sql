




CREATE PROCEDURE [dbo].[Pedidos_TX_PendientesParaLista]
AS
SELECT
 DetPed.IdPedido,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Titulo]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
WHERE((DetPed.Cumplido<>'SI' and DetPed.Cumplido<>'AN') or DetPed.Cumplido is null) AND
	((Pedidos.Cumplido<>'SI' and Pedidos.Cumplido<>'AN') or Pedidos.Cumplido is null) 
GROUP BY DetPed.IdPedido,Pedidos.NumeroPedido,Pedidos.SubNumero
ORDER BY Pedidos.NumeroPedido,Pedidos.SubNumero




