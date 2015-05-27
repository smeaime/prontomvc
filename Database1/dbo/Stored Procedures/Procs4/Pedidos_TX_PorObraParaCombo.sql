




CREATE PROCEDURE [dbo].[Pedidos_TX_PorObraParaCombo]
@IdObra int
AS
SELECT DISTINCT
DetPed.IdPedido,
Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
End as [Titulo]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (Acopios.IdObra is not null and Acopios.IdObra=@IdObra) or 
	 (Requerimientos.IdObra is not null and Requerimientos.IdObra=@IdObra)
ORDER BY [Titulo]




