
CREATE PROCEDURE [dbo].[Recepciones_TX_DatosPorIdDetalleRecepcion]

@IdDetalleRecepcion int

AS

SELECT
 Recepciones.*,
 Requerimientos.NumeroRequerimiento,
 DetReq.NumeroItem as [ItemRM],
 Pedidos.NumeroPedido,
 Pedidos.Subnumero,
 Pedidos.IdMoneda as [IdMonedaPedido],
 Monedas.Nombre as [MonedaPedido],
 DetPed.NumeroItem as [ItemPedido],
 Case When (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0))<>0 and IsNull(Pedidos.Bonificacion,0)<>0 
	Then Round(((DetRec.Cantidad*DetPed.Precio)-
			(DetRec.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100)) - 
			(Pedidos.Bonificacion / (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)) * 
			 ((DetRec.Cantidad*DetPed.Precio)-
			  (DetRec.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100))),2)
	Else Round((DetRec.Cantidad*DetPed.Precio)-(DetRec.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100),2)
 End as [ImporteBonificado],
 Pedidos.CotizacionMoneda
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Pedidos.IdMoneda
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (DetRec.IdDetalleRecepcion = @IdDetalleRecepcion)
