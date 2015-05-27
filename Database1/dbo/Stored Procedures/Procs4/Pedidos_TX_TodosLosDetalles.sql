CREATE Procedure [dbo].[Pedidos_TX_TodosLosDetalles]

@IdPedido int

AS 

SELECT 
 DetPed.*,
 ((DetPed.Precio * (100-IsNull(DetPed.PorcentajeBonificacion,0))/100) * (100-IsNull(Pedidos.PorcentajeBonificacion,0))/100) + 
	Case When IsNull(DetPed.Cantidad,0)<>0 Then (IsNull(DetPed.ImpuestosInternos,0)/IsNull(DetPed.Cantidad,0)) Else 0 End as [PrecioBonificado],
 Pedidos.NumeroPedido,
 DetalleRequerimientos.NumeroItem as [IR],
 Requerimientos.NumeroRequerimiento,
 (Select Sum(DetRec.Cantidad)
  From DetalleRecepciones DetRec
  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
  Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and 
	(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [Entregado],
 DetPed.Cantidad - Isnull((Select Sum(DetRec.Cantidad)
 				From DetalleRecepciones DetRec 
				Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
				Where DetRec.IdDetallePedido=DetPed.IdDetallePedido and 
					(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0)
 as [Pendiente],
 CASE 
	WHEN Acopios.IdObra IS NOT NULL THEN Acopios.IdObra
	WHEN Requerimientos.IdObra IS NOT NULL THEN Requerimientos.IdObra
	ELSE null
 END as [IdObra],
 CASE 
	WHEN Acopios.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
	WHEN Requerimientos.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
	ELSE null
 END as [Obra],
 Pedidos.IdMoneda,
 Pedidos.CotizacionDolar,
 Pedidos.CotizacionMoneda,
 Articulos.IdUbicacionStandar,
 Articulos.Descripcion as [DescripcionArt],
 Articulos.Codigo
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetPed.IdPedido
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento=DetPed.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetalleRequerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
WHERE DetPed.IdPedido=@IdPedido
ORDER BY DetPed.NumeroItem