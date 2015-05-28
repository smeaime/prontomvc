





























CREATE  Procedure [dbo].[LMateriales_TX_DisponibilidadesPed]
@IdDetalleLMateriales int
AS 
SELECT 
	DetPed.IdDetalleLMateriales,
	Pedidos.NumeroPedido as [Nro.pedido],
	DetPed.Cantidad as [Cant.pedida],
	Unidades.Descripcion as [Unidad],
	DetPed.FechaEntrega as [Fec.entrega]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
WHERE DetPed.IdDetalleLMateriales =@IdDetalleLMateriales






























