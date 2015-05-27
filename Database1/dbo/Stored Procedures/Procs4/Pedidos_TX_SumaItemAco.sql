
















CREATE PROCEDURE [dbo].[Pedidos_TX_SumaItemAco]
@IdDetalleAcopios int,
@IdUnidad int
as
SELECT SUM(DetPed.Cantidad) as [Cantidad]
FROM DetallePedidos DetPed
WHERE DetPed.IdDetalleAcopios = @IdDetalleAcopios and DetPed.IdUnidad=@IdUnidad

















