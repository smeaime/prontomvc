
CREATE PROCEDURE [dbo].[Pedidos_TX_Precios]

@Desde datetime,
@Hasta datetime,
@TipoBusqueda int,
@IdBusqueda int,
@Texto varchar(200),
@IdObra int

AS

Declare @vector_X varchar(50),@vector_T varchar(50),@vector_E varchar(100)
Set @vector_X='00111111161661541333'
Set @vector_T='0020400103033D802000'
Set @vector_E='  |  |  |  |  |  |  |  |  |  |  |  |  |  |'

SELECT 
 DetPed.IdDetallePedido,
 DetPed.IdPedido,
 Pedidos.NumeroPedido as [Pedido],
 Pedidos.SubNumero as [Sub],
 Pedidos.FechaPedido as [Fecha],
 DetPed.NumeroItem as [Item],
 Proveedores.RazonSocial as [Proveedor],
 DetPed.Cantidad as [Cant.],
 Monedas.Abreviatura as [Mon.],
 DetPed.Precio as [Precio s/bon.],
 DetPed.PorcentajeBonificacion as [% bon.],
 Case 	When DetPed.PorcentajeBonificacion is null 
	 Then DetPed.Precio
	 Else (DetPed.Precio-(DetPed.Precio*DetPed.PorcentajeBonificacion/100))
 End as [Precio],
 Case 	When DetPed.PorcentajeBonificacion is null 
	 Then DetPed.Precio * DetPed.Cantidad
	 Else (DetPed.Precio-(DetPed.Precio*DetPed.PorcentajeBonificacion/100)) * DetPed.Cantidad
 End as [Importe],
 Articulos.Descripcion as [Articulo],
 DetPed.Observaciones as [Observaciones],
 DetPed.Observaciones as [Observaciones item],
 Case 	When DetPed.IdCentroCosto is not null 
	 Then (Select Top 1 CentrosCosto.Codigo From CentrosCosto
		Where CentrosCosto.IdCentroCosto=DetPed.IdCentroCosto)
	 Else 	Case 	When Acopios.IdObra is not null 
				Then (Select Top 1 Obras.NumeroObra From Obras
					Where Obras.IdObra=Acopios.IdObra)
			When Requerimientos.IdObra is not null 
				Then (Select Top 1 Obras.NumeroObra From Obras
					Where Obras.IdObra=Requerimientos.IdObra)
			Else Null
		End
 End as [Obra/CC],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetPed.IdArticulo
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetPed.IdPedido
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Pedidos.IdProveedor
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Pedidos.IdMoneda
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (Pedidos.FechaPedido>=@Desde and Pedidos.FechaPedido<=@Hasta) and 
	 (Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and 
	 (DetPed.Cumplido is null or DetPed.Cumplido<>'AN') and 
	 ((@TipoBusqueda=1 and Articulos.IdRubro=@IdBusqueda and 
	   (Len(@Texto)=0 or 
	    (Len(@Texto)>0 and (Articulos.Descripcion LIKE '%' + @Texto + '%' or DetPed.Observaciones LIKE '%' + @Texto + '%'))))
	  or 
	  (@TipoBusqueda=2 and Articulos.IdArticulo=@IdBusqueda and 
	   (Len(@Texto)=0 or 
	    (Len(@Texto)>0 and (Articulos.Descripcion LIKE '%' + @Texto + '%' or DetPed.Observaciones LIKE '%' + @Texto + '%'))))
	  or 
	  (@TipoBusqueda=3 and 
	   (Len(@Texto)=0 or 
	    (Len(@Texto)>0 and (Articulos.Descripcion LIKE '%' + @Texto + '%' or DetPed.Observaciones LIKE '%' + @Texto + '%'))))
	  or 
	  @TipoBusqueda=-1) and 
	 (@IdObra=-1 or ((Acopios.IdObra is not null and Acopios.IdObra=@IdObra) or 
			 (Requerimientos.IdObra is not null and Requerimientos.IdObra=@IdObra)))
ORDER BY Pedidos.FechaPedido desc,Pedidos.NumeroPedido,Pedidos.SubNumero
