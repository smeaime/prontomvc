
CREATE PROCEDURE [dbo].[RecepcionesSAT_TX_EntreFechas]

@Desde datetime,
@Hasta datetime

AS

SELECT
 dr.IdDetalleRecepcion,
 Case 	When RecepcionesSAT.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,RecepcionesSAT.NumeroRecepcion1)))+
			Convert(varchar,RecepcionesSAT.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,RecepcionesSAT.NumeroRecepcion2)))+
			Convert(varchar,RecepcionesSAT.NumeroRecepcion2)+'/'+
			Convert(varchar,RecepcionesSAT.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,RecepcionesSAT.NumeroRecepcion1)))+
			Convert(varchar,RecepcionesSAT.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,RecepcionesSAT.NumeroRecepcion2)))+
			Convert(varchar,RecepcionesSAT.NumeroRecepcion2),1,20) 
 End as [Recepcion],
 RecepcionesSAT.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Proveedores.RazonSocial as [Proveedor],
 DetalleRequerimientos.FechaEntrega as [Fecha necesidad],
 DetallePedidos.FechaEntrega as [Fecha promesa],
 RecepcionesSAT.FechaRecepcion as [Fecha entrega],
 Case When DateDiff(d,DetallePedidos.FechaEntrega,RecepcionesSAT.FechaRecepcion)<=0 
	Then DateDiff(d,DetallePedidos.FechaEntrega,RecepcionesSAT.FechaRecepcion) * -1
	Else Null
 End as [En termino (dias)],
 Case When DateDiff(d,DetallePedidos.FechaEntrega,RecepcionesSAT.FechaRecepcion)>0 
	Then DateDiff(d,DetallePedidos.FechaEntrega,RecepcionesSAT.FechaRecepcion)
	Else Null
 End as [Fuera de termino (dias)],
 Articulos.Descripcion as [Material],
 dr.Observaciones as [Observaciones],
 dr.CantidadCC as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 Obras.NumeroObra as [Obra],
 Requerimientos.NumeroRequerimiento as [RM],
 DetalleRequerimientos.NumeroItem as [Item RM],
 Case 	When Pedidos.SubNumero is not null 
	Then Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)+'/'+
		Convert(varchar,Pedidos.SubNumero)
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)
 End as [Pedido],
 DetallePedidos.NumeroItem as [Item pedido],
 Rubros.Descripcion as [Rubro],
 Empleados.Nombre as [Solicito],
 atd.Descripcion as [Origen de transmision]
From DetalleRecepcionesSAT dr
Left Outer Join RecepcionesSAT On dr.IdRecepcion=RecepcionesSAT.IdRecepcion
Left Outer Join Articulos On dr.IdArticulo=Articulos.IdArticulo
Left Outer Join Rubros On Articulos.IdRubro=Rubros.IdRubro
Left Outer Join Unidades On dr.IdUnidad=Unidades.IdUnidad
Left Outer Join Proveedores On RecepcionesSAT.IdProveedor = Proveedores.IdProveedor
Left Outer Join Obras On dr.IdObra=Obras.IdObra
Left Outer Join DetalleRequerimientos On dr.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimientoOriginal and 
					dr.IdOrigenTransmision=DetalleRequerimientos.IdOrigenTransmision
Left Outer Join Requerimientos On DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento
Left Outer Join DetallePedidos On dr.IdDetallePedido = DetallePedidos.IdDetallePedido
Left Outer Join Pedidos On DetallePedidos.IdPedido = Pedidos.IdPedido
Left Outer Join Empleados On Requerimientos.IdSolicito = Empleados.IdEmpleado
Left Outer Join ArchivosATransmitirDestinos atd On dr.IdOrigenTransmision = atd.IdArchivoATransmitirDestino
Where 	Controlado is not null and 
	IsNull(RecepcionesSAT.Anulada,'NO')<>'SI' and 
	RecepcionesSAT.FechaRecepcion Between @Desde and @Hasta
Order By RecepcionesSAT.FechaRecepcion, RecepcionesSAT.NumeroRecepcionAlmacen, 
	DetallePedidos.NumeroItem, [Recepcion]
