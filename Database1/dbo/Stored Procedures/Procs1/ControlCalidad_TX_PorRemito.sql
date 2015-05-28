





























CREATE PROCEDURE [dbo].[ControlCalidad_TX_PorRemito]
@IdDetalleRecepcion int
as
Declare @NumeroRecepcion1 int,@NumeroRecepcion2 int,@IdProveedor int
Set @NumeroRecepcion1=(Select Recepciones.NumeroRecepcion1 
			From DetalleRecepciones
			LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
			Where DetalleRecepciones.IdDetalleRecepcion = @IdDetalleRecepcion)
Set @NumeroRecepcion2=(Select Recepciones.NumeroRecepcion2 
			From DetalleRecepciones
			LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
			Where DetalleRecepciones.IdDetalleRecepcion = @IdDetalleRecepcion)
Set @IdProveedor=(Select Recepciones.IdProveedor 
			From DetalleRecepciones
			LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
			Where DetalleRecepciones.IdDetalleRecepcion = @IdDetalleRecepcion)
SELECT
DetRec.IdDetalleRecepcion,
DetRec.IdRecepcion,
DetRec.IdDetallePedido,
DetRec.IdArticulo,
Recepciones.IdProveedor,
Proveedores.RazonSocial as [Proveedor],
Recepciones.NumeroRecepcion1,
Recepciones.NumeroRecepcion2,
Recepciones.SubNumero,
str(Recepciones.NumeroRecepcion1,4)+'-'+str(Recepciones.NumeroRecepcion2,8) as [Recepcion],
Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
Recepciones.FechaRecepcion as [Fecha recepcion],
substring(ControlesCalidad.Descripcion,1,20) as [Control de Calidad],
DetRec.Controlado,
Pedidos.NumeroPedido as [Pedido],
Pedidos.SubNumero as [SubPedido],
Pedidos.FechaPedido as [Fecha pedido],
DetallePedidos.NumeroItem as [It.Ped],
Requerimientos.NumeroRequerimiento as [RM],
Requerimientos.FechaRequerimiento as [FechaRM],
DetalleRequerimientos.NumeroItem as [It.RM],
Acopios.NumeroAcopio as [LA],
Acopios.Fecha as [FechaLA],
DetalleAcopios.NumeroItem as [It.LA],
DetRec.Partida as [Partida],
DetRec.Cantidad as [Cant.],
DetRec.Cantidad1 as [Med.1],
DetRec.Cantidad2 as [Med.2],
DetRec.IdUnidad,
( SELECT Unidades.Descripcion
	FROM Unidades
	WHERE Unidades.IdUnidad=DetRec.IdUnidad) as  [Unidad en],
DetRec.CantidadCC as [Aprobado],
DetRec.CantidadRechazadaCC as [Rechazado],
Articulos.Descripcion as Articulo,
Recepciones.IdTransportista,
Recepciones.Acargo
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetRec.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetallePedidos ON DetRec.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleRequerimientos ON DetRec.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleAcopios ON DetRec.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
WHERE Recepciones.NumeroRecepcion1=@NumeroRecepcion1 And 
	Recepciones.NumeroRecepcion2=@NumeroRecepcion2 And 
	Recepciones.IdProveedor=@IdProveedor






























