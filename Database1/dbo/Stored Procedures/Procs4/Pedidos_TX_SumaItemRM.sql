
















CREATE PROCEDURE [dbo].[Pedidos_TX_SumaItemRM]
@IdDetalleRequerimiento int,
@IdUnidad int
AS
SELECT SUM(DetPed.Cantidad) as [Cantidad]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetPed.IdPedido
WHERE DetPed.IdDetalleRequerimiento = @IdDetalleRequerimiento and 
	DetPed.IdUnidad=@IdUnidad and 
	(Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and 
	(DetPed.Cumplido is null or DetPed.Cumplido<>'AN')

















