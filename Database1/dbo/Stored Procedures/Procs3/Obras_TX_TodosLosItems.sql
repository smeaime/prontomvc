































CREATE PROCEDURE [dbo].[Obras_TX_TodosLosItems]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111111111111111111133'
set @vector_T='04241111444444444444444444400'
SELECT
DetLA.IdDetalleAcopios as [Id],
Obras.NumeroObra as [Obra],
Equipos.Tag as [Equipo],
'L.Acopio' as [Comprobante],
Acopios.NumeroAcopio as [Numero],
DetLA.NumeroItem as [Item],
Empleados.Nombre as [Emisor],
Sectores.Descripcion as [Sector],
DetLA.FechaNecesidad as [Fecha nec.],
Null as [Total items],
Null as [Cumplido],
Null as [Fecha ult.firma],
Articulos.Descripcion as [Articulo],
DetLA.Cantidad as [Cant.],
( SELECT substring(Unidades.Descripcion,1,20)
	FROM Unidades
	WHERE Unidades.IdUnidad=DetLA.IdUnidad ) as [Unidad en],
Pedidos.NumeroPedido as [Pedido],
Pedidos.FechaPedido as [Fecha],
Proveedores.RazonSocial as [Proveedor],
( SELECT Empleados.Nombre
	FROM Empleados
	WHERE Empleados.IdEmpleado=Pedidos.IdComprador ) as [Comprador],
DetallePedidos.FechaEntrega as [F.entrega],
( Pedidos.TotalPedido-Pedidos.TotalIva1 ) as [Importe s/iva],
Case
	When Recepciones.NumeroRecepcion1 is not null Then str(Recepciones.NumeroRecepcion1,4)+'-'+str(Recepciones.NumeroRecepcion2,8)
	Else Null
End as [Numero recepcion],
Recepciones.FechaRecepcion as [Fecha recepcion],
DetalleRecepciones.Cantidad as [Cant.recibida],
Null as [Factura],
Null as [Fecha factura],
Null as [Importe factura]
FROM DetalleAcopios DetLA
LEFT OUTER JOIN Acopios ON DetLA.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN Obras ON Acopios.IdObra = Obras.IdObra
LEFT OUTER JOIN DetalleLMateriales ON DetLA.IdDetalleAcopios = DetalleLMateriales.IdDetalleAcopios
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
LEFT OUTER JOIN Empleados ON Acopios.Realizo=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Articulos ON DetLA.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetallePedidos ON DetLA.IdDetalleAcopios = DetallePedidos.IdDetalleAcopios
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleRecepciones ON DetallePedidos.IdDetallePedido=DetalleRecepciones.IdDetallePedido
LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
UNION
SELECT
DetRM.IdDetalleRequerimiento as [Id],
Obras.NumeroObra as [Obra],
Equipos.Tag as [Equipo],
'R.M.' as [Comprobante],
Requerimientos.NumeroRequerimiento as [Numero],
DetRM.NumeroItem as [Item],
Empleados.Nombre as [Emisor],
Sectores.Descripcion as [Sector],
DetRM.FechaEntrega as [Fecha nec.],
( SELECT count(*) 
	FROM DetalleRequerimientos dr
	WHERE dr.IdRequerimiento=DetRM.IdRequerimiento) as [Total items],
DetRM.Cumplido as [Cumplido],
( SELECT TOP 1 AutorizacionesPorComprobante.FechaAutorizacion
	FROM AutorizacionesPorComprobante
	WHERE AutorizacionesPorComprobante.IdFormulario=3 and AutorizacionesPorComprobante.IdComprobante=DetRM.IdRequerimiento) as [Fecha ult.firma],
Articulos.Descripcion as [Articulo],
DetRM.Cantidad as [Cant.],
( SELECT TOP 1 substring(Unidades.Descripcion,1,20)
	FROM Unidades
	WHERE Unidades.IdUnidad=DetRM.IdUnidad ) as [Unidad en],
Pedidos.NumeroPedido as [Pedido],
Pedidos.FechaPedido as [Fecha],
Case
	When Not DetRM.IdProveedor is null Then 
		(Select Proveedores.RazonSocial From Proveedores Where DetRM.IdProveedor = Proveedores.IdProveedor)
	Else 
		(Select Proveedores.RazonSocial From Proveedores Where Pedidos.IdProveedor = Proveedores.IdProveedor)
End as [Proveedor],
( SELECT TOP 1 Empleados.Nombre
	FROM Empleados
	WHERE Empleados.IdEmpleado=Pedidos.IdComprador ) as [Comprador],
DetallePedidos.FechaEntrega as [F.entrega],
( Pedidos.TotalPedido-Pedidos.TotalIva1 ) as [Importe s/iva],
Case
	When EXISTS(	Select Top 1 DetalleRecepciones.IdRecepcion 
			From DetalleRecepciones 
			Where DetRM.IdDetalleRequerimiento=DetalleRecepciones.IdDetalleRequerimiento )
		Then (	Select Top 1 str(Recepciones.NumeroRecepcion1,4)+'-'+str(Recepciones.NumeroRecepcion2,8) 
			From Recepciones 
			Where Recepciones.IdRecepcion=( Select Top 1 DetalleRecepciones.IdRecepcion 
							From DetalleRecepciones 
							Where DetRM.IdDetalleRequerimiento=DetalleRecepciones.IdDetalleRequerimiento ) )
	When EXISTS(	Select Top 1 DetalleRecepciones.IdRecepcion 
			From DetalleRecepciones 
			Where DetallePedidos.IdDetallePedido=DetalleRecepciones.IdDetallePedido )
		Then (	Select Top 1 str(Recepciones.NumeroRecepcion1,4)+'-'+str(Recepciones.NumeroRecepcion2,8) 
			From Recepciones 
			Where Recepciones.IdRecepcion=( Select Top 1 DetalleRecepciones.IdRecepcion 
							From DetalleRecepciones 
							Where DetallePedidos.IdDetallePedido=DetalleRecepciones.IdDetallePedido ) )
	Else Null
End as [Numero recepcion],
Case
	When EXISTS(	Select Top 1 DetalleRecepciones.IdRecepcion 
			From DetalleRecepciones 
			Where DetRM.IdDetalleRequerimiento=DetalleRecepciones.IdDetalleRequerimiento )
		Then (	Select Top 1 Recepciones.FechaRecepcion 
			From Recepciones 
			Where Recepciones.IdRecepcion=( Select Top 1 DetalleRecepciones.IdRecepcion 
							From DetalleRecepciones 
							Where DetRM.IdDetalleRequerimiento=DetalleRecepciones.IdDetalleRequerimiento ) )
	When EXISTS(	Select Top 1 DetalleRecepciones.IdRecepcion 
			From DetalleRecepciones 
			Where DetallePedidos.IdDetallePedido=DetalleRecepciones.IdDetallePedido )
		Then (	Select Top 1 Recepciones.FechaRecepcion 
			From Recepciones 
			Where Recepciones.IdRecepcion=( Select Top 1 DetalleRecepciones.IdRecepcion 
							From DetalleRecepciones 
							Where DetallePedidos.IdDetallePedido=DetalleRecepciones.IdDetallePedido ) )
	Else Null
End as [Fecha recepcion],
Case
	When EXISTS(	Select Top 1 DetalleRecepciones.IdRecepcion 
			From DetalleRecepciones 
			Where DetRM.IdDetalleRequerimiento=DetalleRecepciones.IdDetalleRequerimiento )
		Then (	Select Top 1 DetalleRecepciones.Cantidad 
			From DetalleRecepciones 
			Where DetRM.IdDetalleRequerimiento=DetalleRecepciones.IdDetalleRequerimiento )
	When EXISTS(	Select Top 1 DetalleRecepciones.IdRecepcion 
			From DetalleRecepciones 
			Where DetallePedidos.IdDetallePedido=DetalleRecepciones.IdDetallePedido )
		Then (	Select Top 1 DetalleRecepciones.Cantidad 
			From DetalleRecepciones 
			Where DetallePedidos.IdDetallePedido=DetalleRecepciones.IdDetallePedido )
	Else Null
End as [Cant.recibida],
str(DetRM.NumeroFacturaCompra1,4)+' - '+str(DetRM.NumeroFacturaCompra2,8) as [Factura],
DetRM.FechaFacturaCompra as [Fecha factura],
DetRM.ImporteFacturaCompra as [Importe factura]
FROM DetalleRequerimientos DetRM
LEFT OUTER JOIN Requerimientos ON DetRM.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN DetalleLMateriales ON DetRM.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
LEFT OUTER JOIN Empleados ON Requerimientos.IdSolicito=Empleados.IdEmpleado
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Articulos ON DetRM.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetalleRequerimiento=DetRM.IdDetalleRequerimiento
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
Order By Obras.NumeroObra,Equipos.Tag,Articulos.Descripcion
































