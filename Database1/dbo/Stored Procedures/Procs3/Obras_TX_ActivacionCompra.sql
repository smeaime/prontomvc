




CREATE Procedure [dbo].[Obras_TX_ActivacionCompra]

AS 

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='000111111114111111111111133'
set @vector_T='000710330405222122255033300'

Select
 0,
 Tmp.IdDetalleRequerimiento,
 Tmp.IdDetalleAcopios,
 Obras.NumeroObra as [Obra],
 Equipos.Tag as [Equipo],
 Tmp.Tipo,
 Tmp.NumeroComprobante as [Comprob.],
 LMateriales.Nombre as [Nombre],
 Tmp.Item,
 Tmp.FechaNecesidad as [F.necesidad],
 Articulos.Descripcion as [Material],
 Tmp.Observaciones,
 Case 	When Tmp.Cantidad=0 Then Null
	Else Tmp.Cantidad
 End as [Cantidad],
 Tmp.Cantidad1 as [Med.1],
 Tmp.Cantidad2 as [Med.1],
 Unidades.Abreviatura as [En],
 Tmp.TipoPedido as [Tipo solicitud],
 Tmp.Pedido as [Nro.Pedido],
 Tmp.CantidadPedida as [Cant.pedida],
 Tmp.FechaSolicitud as [Fecha solicitud],
 Tmp.FechaEntrega as [Fecha entrega],
 Tmp.Comprador,
 Case 	When Tmp.CantidadReservada=0 Then Null
	Else Tmp.CantidadReservada
 End as [Cant.reservada],
 Case 	When Tmp.CantidadRecibida=0 then Null 
	Else Tmp.CantidadRecibida
 End as [Cant.recibida],
 Tmp.Cantidad-Tmp.CantidadReservada-Tmp.CantidadRecibida as [Cant.faltante],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
From _TempActivacionCompraMateriales Tmp
Left Outer Join Obras On Obras.IdObra=Tmp.IdObra
Left Outer Join Equipos On Equipos.IdEquipo=Tmp.IdEquipo
Left Outer Join Articulos On Articulos.IdArticulo=Tmp.IdArticulo
Left Outer Join Unidades On Unidades.IdUnidad=Tmp.IdUnidad
Left Outer Join DetalleLMateriales On DetalleLMateriales.IdDetalleLMateriales=Tmp.IdDetalleLMateriales
Left Outer Join LMateriales On LMateriales.IdLMateriales=DetalleLMateriales.IdLMateriales
Order By Obras.NumeroObra,Equipos.Tag,Tmp.IdDetalleRequerimiento,Tmp.IdDetalleAcopios,Tmp.Codigo




