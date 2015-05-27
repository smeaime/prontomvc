
CREATE PROCEDURE [dbo].[ControlCalidad_TX_TT]

@IdDetalleRecepcion int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011111111111111111133'
Set @vector_T='0E2455C22240339903300'

SELECT TOP 1
 DetRec.IdDetalleRecepcion,
 Articulos.Descripcion as [Articulo],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
 End as [Recepcion],
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Recepciones.FechaRecepcion as [Fecha recepcion],
 ControlesCalidad.Descripcion as [Control de Calidad],
 DetRec.Controlado,
 Pedidos.NumeroPedido as [Pedido],
 Obras.NumeroObra as [Obra],
 Pedidos.FechaPedido as [Fecha pedido],
 DetallePedidos.NumeroItem as [It.Ped],
 DetRec.Partida as [Partida],
 DetRec.Cantidad as [Cant.],
 DetRec.Cantidad1 as [Med.1],
 DetRec.Cantidad2 as [Med.2],
 Unidades.Abreviatura as [Un.],
 DetRec.CantidadCC as [Aprobado],
 DetRec.CantidadRechazadaCC as [Rechazado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetRec.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetallePedidos ON DetRec.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Unidades ON DetRec.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleRequerimientos ON DetallePedidos.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON DetRec.IdObra = Obras.IdObra
WHERE IdDetalleRecepcion=@IdDetalleRecepcion and ( DetRec.Controlado is null or DetRec.Controlado='PA' )
