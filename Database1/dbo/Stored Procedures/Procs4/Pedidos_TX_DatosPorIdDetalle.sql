CREATE PROCEDURE [dbo].[Pedidos_TX_DatosPorIdDetalle]

@IdDetallePedido int

AS

SELECT
 DetPed.IdDetallePedido,
 Pedidos.NumeroPedido,
 Pedidos.FechaPedido,
 DetPed.NumeroItem as [IP],
 Acopios.NumeroAcopio,
 Acopios.Fecha as [FechaAcopio],
 DetalleAcopios.NumeroItem as [IA],
 Requerimientos.NumeroRequerimiento,
 Requerimientos.FechaRequerimiento,
 DetalleRequerimientos.NumeroItem as [IR],
 DetPed.Precio,
 DetPed.Cantidad,
 DetPed.Cantidad1,
 DetPed.Cantidad2,
 DetPed.CantidadRecibida,
 Unidades.Descripcion as  [Unidad en],
 substring(Articulos.Descripcion,1,50) as [Articulo],
 Articulos.Descripcion as [DescripcionArt],
 DetPed.FechaEntrega,
 Pedidos.SubNumero,
 Pedidos.Aprobo,
 Pedidos.IdProveedor,
 Pedidos.IdPedido,
 Pedidos.IdComprador,
 DetPed.IdUnidad,
 DetPed.IdArticulo,
 DetPed.IdDetalleRequerimiento,
 DetPed.IdControlCalidad,
 DetPed.Observaciones,
 DetPed.IdDetalleAcopios,
 DetPed.NumeroItem,
 (DetPed.Precio * (100-IsNull(DetPed.PorcentajeBonificacion,0))/100) * (100-IsNull(Pedidos.PorcentajeBonificacion,0))/100 as [PrecioBonificado],
 Case When (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0))<>0 and IsNull(Pedidos.Bonificacion,0)<>0 
	Then Round(((DetPed.Cantidad*DetPed.Precio)-
			(DetPed.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100)) - 
			(Pedidos.Bonificacion / (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)) * 
			 ((DetPed.Cantidad*DetPed.Precio)-
			  (DetPed.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100))),2)
	Else Round((DetPed.Cantidad*DetPed.Precio)-(DetPed.Cantidad*DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100),2)
 End as [ImporteBonificado],
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
	WHEN Acopios.IdObra IS NOT NULL THEN (Select Obras.Descripcion From Obras Where Acopios.IdObra=Obras.IdObra)
	WHEN Requerimientos.IdObra IS NOT NULL THEN (Select Obras.Descripcion From Obras Where Requerimientos.IdObra=Obras.IdObra)
	ELSE null
 END as [Obra],
 DetPed.IdAsignacionCosto,
 DetPed.CostoAsignado,
 Pedidos.IdMoneda,
 Pedidos.CotizacionDolar,
 Pedidos.CotizacionMoneda,
 Pedidos.PedidoExterior,
 Pedidos.TotalPedido,
 Articulos.IdUbicacionStandar,
 Articulos.Codigo
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE DetPed.IdDetallePedido=@IdDetallePedido