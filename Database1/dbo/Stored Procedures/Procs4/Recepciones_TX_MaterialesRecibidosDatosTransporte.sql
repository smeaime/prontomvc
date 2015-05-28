
CREATE PROCEDURE [dbo].[Recepciones_TX_MaterialesRecibidosDatosTransporte]

@Desde datetime,
@Hasta datetime,
@IdObra int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111133'
SET @vector_T='055555555555500'

SELECT
 dr.IdDetalleRecepcion,
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
 Recepciones.FechaRecepcion as [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When Pedidos.SubNumero is not null 
	Then Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)+'/'+
		Convert(varchar,Pedidos.SubNumero)
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)
 End as [Pedido],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Material],
 dr.Cantidad as [Cantidad],
 dr.CantidadEnOrigen as [CantidadEnOrigen],
 Transportistas.RazonSocial as [Transportista],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Recepciones.NumeroRecepcionOrigen1,0))))+
	Convert(varchar,IsNull(Recepciones.NumeroRecepcionOrigen1,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,IsNull(Recepciones.NumeroRecepcionOrigen2,0))))+
	Convert(varchar,IsNull(Recepciones.NumeroRecepcionOrigen2,0)) as [RemitoTransportista],
 A2.NumeroPatente as [NumeroPatente],
 Recepciones.Chofer as [Chofer],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones dr
LEFT OUTER JOIN Recepciones ON dr.IdRecepcion=Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos A1 ON dr.IdArticulo=A1.IdArticulo
LEFT OUTER JOIN Articulos A2 ON Recepciones.IdEquipo=A2.IdArticulo
LEFT OUTER JOIN Transportistas ON Recepciones.IdTransportista=Transportistas.IdTransportista
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleRequerimientos ON dr.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetallePedidos ON dr.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
WHERE Controlado is not null and IsNull(Recepciones.Anulada,'NO')<>'SI' and 
	Recepciones.FechaRecepcion Between @Desde and @Hasta and 
	(@IdObra=-1 or @IdObra=dr.IdObra)
ORDER BY Recepciones.FechaRecepcion, Recepciones.NumeroRecepcion1, Recepciones.NumeroRecepcion2
