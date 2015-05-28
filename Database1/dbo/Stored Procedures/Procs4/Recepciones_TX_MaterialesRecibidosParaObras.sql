CREATE PROCEDURE [dbo].[Recepciones_TX_MaterialesRecibidosParaObras]

@Desde datetime,
@Hasta datetime,
@IdObra int,
@IdArticulo int = Null,
@Numero int = Null,
@IdProveedor int = Null

AS

SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @Numero=IsNull(@Numero,-1)
SET @IdProveedor=IsNull(@IdProveedor,-1)

SELECT
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Material],
 Convert(varchar(4000),dr.Observaciones) as [Observaciones],
 Convert(varchar(4000),dr.Observaciones) as [Observaciones1],
 Proveedores.RazonSocial as [Proveedor],
 Substring('00000000',1,8-Len(Convert(varchar,Requerimientos.NumeroRequerimiento)))+Convert(varchar,Requerimientos.NumeroRequerimiento) as [RM],
 DetalleRequerimientos.NumeroItem as [Item RM],
 Case When Pedidos.SubNumero is not null 
	Then Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+'/'+Convert(varchar,Pedidos.SubNumero)
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)
 End as [Pedido],
 DetallePedidos.NumeroItem as [Item pedido],
 'RECEPCION' as [Tipo],
 Case 	When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
 End as [Comprobante],
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 E2.Nombre as [Realizo],
 Obras.NumeroObra as [Obra],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 E1.Nombre as [Solicito],
 dr.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 dr.CostoUnitario*dr.CotizacionMoneda as [Costo],
 dr.Cantidad*dr.CostoUnitario*dr.CotizacionMoneda as [TotalItem],
 DetalleRequerimientos.MoP as [MoP]
FROM DetalleRecepciones dr
LEFT OUTER JOIN Recepciones ON dr.IdRecepcion=Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos ON dr.IdArticulo=Articulos.IdArticulo
LEFT OUTER JOIN Rubros ON Articulos.IdRubro=Rubros.IdRubro
LEFT OUTER JOIN Unidades ON dr.IdUnidad=Unidades.IdUnidad
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Obras ON dr.IdObra=Obras.IdObra
LEFT OUTER JOIN DetalleRequerimientos ON dr.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetallePedidos ON dr.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Empleados E1 ON Requerimientos.IdSolicito = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Recepciones.Realizo = E2.IdEmpleado
LEFT OUTER JOIN Cuentas A1 ON Articulos.IdCuentaCompras = A1.IdCuenta
LEFT OUTER JOIN Cuentas A2 ON Articulos.IdCuenta = A2.IdCuenta
LEFT OUTER JOIN Ubicaciones ON dr.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE Controlado is not null and 
	IsNull(Recepciones.Anulada,'NO')<>'SI' and 
	Recepciones.FechaRecepcion Between @Desde and @Hasta and 
	Recepciones.IdProveedor is not null and 
	(@IdObra=-1 or @IdObra=dr.IdObra) and 
	(@IdArticulo=-1 or @IdArticulo=dr.IdArticulo) and 
	(@Numero=-1 or @Numero=Pedidos.NumeroPedido) and 
	(@IdProveedor=-1 or @IdProveedor=Recepciones.IdProveedor)  

UNION ALL

SELECT 
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Material],
 Convert(varchar(4000),doia.Observaciones) as [Observaciones],
 Convert(varchar(4000),doia.Observaciones) as [Observaciones1],
 Null as [Proveedor],
 Null as [RM],
 Null as [Item RM],
 Null as [Pedido],
 Null as [Item pedido],
 'OTROS ING.' as [Tipo],
 Substring('00000000',1,8-Len(Convert(varchar,oia.NumeroOtroIngresoAlmacen)))+Convert(varchar,oia.NumeroOtroIngresoAlmacen) as [Comprobante],
 Null as [Nro.recep.alm.],
 Empleados.Nombre as [Realizo],
 Obras.NumeroObra as [Obra],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 Null as [Solicito],
 IsNull(doia.CantidadCC,doia.Cantidad) as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 Null as [Costo],
 Null as [TotalItem],
 Null as [MoP]
FROM DetalleOtrosIngresosAlmacen doia
LEFT OUTER JOIN OtrosIngresosAlmacen oia ON doia.IdOtroIngresoAlmacen=oia.IdOtroIngresoAlmacen
LEFT OUTER JOIN Articulos ON doia.IdArticulo=Articulos.IdArticulo
LEFT OUTER JOIN Rubros ON Articulos.IdRubro=Rubros.IdRubro
LEFT OUTER JOIN Unidades ON doia.IdUnidad=Unidades.IdUnidad
LEFT OUTER JOIN Obras ON oia.IdObra=Obras.IdObra
LEFT OUTER JOIN Cuentas A1 ON Articulos.IdCuentaCompras = A1.IdCuenta
LEFT OUTER JOIN Cuentas A2 ON Articulos.IdCuenta = A2.IdCuenta
LEFT OUTER JOIN Empleados ON oia.Emitio = Empleados.IdEmpleado
LEFT OUTER JOIN Ubicaciones ON doia.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE IsNull(oia.Anulado,'NO')<>'SI' and 
	oia.FechaOtroIngresoAlmacen Between @Desde and @Hasta and 
	(@IdObra=-1 or @IdObra=oia.IdObra) and 
	(@IdArticulo=-1 or @IdArticulo=doia.IdArticulo) and 
	@Numero=-1 and @IdProveedor=-1

ORDER BY [Tipo] desc, [Comprobante], [Nro.recep.alm.], [Item pedido]