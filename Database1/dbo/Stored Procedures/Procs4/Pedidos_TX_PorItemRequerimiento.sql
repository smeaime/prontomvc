CREATE PROCEDURE [dbo].[Pedidos_TX_PorItemRequerimiento]

@IdDetalleRequerimiento int, 
@IdRequerimiento int = Null

AS

SET @IdRequerimiento=IsNull(@IdRequerimiento,-1)

SELECT DetPed.IdDetallePedido, DetPed.NumeroItem, Pedidos.IdProveedor, Pedidos.FechaPedido, 
	Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido], 
	IsNull((Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec 
		Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
		Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and IsNull(Recepciones.Anulada,'')<>'SI'),0) as [Entregado]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento = DetPed.IdDetalleRequerimiento
WHERE IsNull(DetPed.Cumplido,'NO')<>'AN' and 
	(@IdDetalleRequerimiento=-1 or DetPed.IdDetalleRequerimiento = @IdDetalleRequerimiento) and 
	(@IdRequerimiento=-1 or DetalleRequerimientos.IdRequerimiento = @IdRequerimiento)