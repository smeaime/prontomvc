CREATE PROCEDURE [dbo].[Recepciones_TX_SinFactura]

@Desde datetime,
@Hasta datetime,
@IdObra int = Null,
@IdCuenta int = Null,
@IdArticulo int = Null,
@NumeroRemito int = Null,
@IdProveedor int = Null,
@NumeroPedido int = Null

AS

SET @IdObra=IsNull(@IdObra,-1)
SET @IdCuenta=IsNull(@IdCuenta,-1)
SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @NumeroRemito=IsNull(@NumeroRemito,-1)
SET @IdProveedor=IsNull(@IdProveedor,-1)
SET @NumeroPedido=IsNull(@NumeroPedido,-1)

SELECT
 dr.IdDetalleRecepcion,
 Recepciones.FechaRecepcion as [FechaRecepcion],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+
			IsNull('/'+Convert(varchar,Recepciones.SubNumero),'') as [Recepcion],
 Recepciones.NumeroRecepcionAlmacen as [NumeroRecepcionAlmacen],
 Proveedores.CodigoEmpresa as [CodigoProveedor], 
 Proveedores.RazonSocial as [Proveedor],
 Articulos.Codigo as [CodigoArticulo],
 Articulos.Descripcion as [Articulo],
 C2.Codigo as [CodigoCuentaCompra],
 C2.Descripcion as [CuentaCompra],
 Requerimientos.NumeroRequerimiento as [NumeroRequerimiento],
 DetalleRequerimientos.NumeroItem as [NumeroItemRequerimiento],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 DetallePedidos.NumeroItem as [NumeroItemPedido],
 E2.Nombre as [Realizo],
 Convert(varchar(4000),Recepciones.Observaciones) as [ObservacionesCabeza], 
 Obras.NumeroObra as [Obra],
 E1.Nombre as [Solicito],
 dr.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 dr.CostoUnitario*dr.CotizacionMoneda as [Costo],
 dr.Cantidad*dr.CostoUnitario*dr.CotizacionMoneda as [CostoTotalItem],
 C1.Codigo as [CodigoCuenta],
 C1.Descripcion as [Cuenta],
 Convert(varchar(4000),dr.Observaciones) as [Observaciones],
 Rubros.Descripcion as [Rubro]
FROM DetalleRecepciones dr
LEFT OUTER JOIN Recepciones ON dr.IdRecepcion=Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos ON dr.IdArticulo=Articulos.IdArticulo
LEFT OUTER JOIN Rubros ON Articulos.IdRubro=Rubros.IdRubro
LEFT OUTER JOIN Unidades ON dr.IdUnidad=Unidades.IdUnidad
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Obras ON dr.IdObra=Obras.IdObra
LEFT OUTER JOIN DetalleRequerimientos ON dr.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido=dr.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetallePedidos.IdPedido
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Requerimientos.IdSolicito
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Recepciones.Realizo
LEFT OUTER JOIN Cuentas C1 ON C1.IdCuenta=Articulos.IdCuentaCompras
LEFT OUTER JOIN Cuentas C2 ON C2.IdCuenta=Articulos.IdCuenta
WHERE Controlado is not null and IsNull(Recepciones.Anulada,'NO')<>'SI' and 
	Recepciones.FechaRecepcion Between @Desde and @Hasta and IsNull(Recepciones.IdProveedor,0)>0 and 
	Not Exists(Select Top 1 dcp.IdDetalleComprobanteProveedor From DetalleComprobantesProveedores dcp Where dcp.IdDetalleRecepcion=dr.IdDetalleRecepcion) and 
	(@IdObra=-1 or @IdObra=dr.IdObra) and 
	(@IdCuenta=-1 or @IdCuenta=Articulos.IdCuentaCompras) and 
	(@IdArticulo=-1 or @IdArticulo=dr.IdArticulo) and 
	(@NumeroRemito=-1 or @NumeroRemito=Recepciones.NumeroRecepcion2) and 
	(@IdProveedor=-1 or @IdProveedor=Recepciones.IdProveedor) and  
	(@NumeroPedido=-1 or @NumeroPedido=Pedidos.NumeroPedido) and 
	Recepciones.IdProveedor is not null
ORDER BY Recepciones.FechaRecepcion, Recepciones.NumeroRecepcionAlmacen, DetallePedidos.NumeroItem