CREATE PROCEDURE [dbo].[Recepciones_TX_MaterialesRecibidos]

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
 'RECEPCION' as [Tipo],
 Case 	When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
 End as [Recepcion],
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Proveedores.RazonSocial as [Proveedor],
 DetalleRequerimientos.FechaEntrega as [Fecha necesidad],
 DetallePedidos.FechaEntrega as [Fecha promesa],
 Recepciones.FechaRecepcion as [Fecha entrega],
 Case When DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion)<=0 
	Then DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion) * -1
	Else Null
 End as [En termino (dias)],
 Case When DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion)>0 
	Then DateDiff(d,DetallePedidos.FechaEntrega,Recepciones.FechaRecepcion)
	Else Null
 End as [Fuera de termino (dias)],
 Articulos.Descripcion as [Material],
 Articulos.Codigo as [Codigo],
 Convert(varchar(4000),dr.Observaciones) as [Observaciones],
 Convert(varchar(4000),dr.Observaciones) as [Observaciones1],
 dr.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 Case
	When dr.IdDetalleAcopios is not null 
		Then (Select LMateriales.NumeroLMateriales
			From LMateriales
			Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
								From DetalleLMateriales
								Where DetalleLMateriales.IdDetalleAcopios=dr.IdDetalleAcopios))
	When dr.IdDetalleRequerimiento is not null 
		Then (Select LMateriales.NumeroLMateriales
			From LMateriales
			Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
								From DetalleLMateriales
								Where DetalleLMateriales.IdDetalleLMateriales=(Select Top 1 DetalleRequerimientos.IdDetalleLMateriales
														From DetalleRequerimientos
														Where DetalleRequerimientos.IdDetalleRequerimiento=dr.IdDetalleRequerimiento)))
	When dr.IdDetallePedido is not null 
		Then (Select LMateriales.NumeroLMateriales
			From LMateriales
			Where LMateriales.IdLMateriales=(Select Top 1 DetalleLMateriales.IdLMateriales
								From DetalleLMateriales
								Where DetalleLMateriales.IdDetalleLMateriales=(Select Top 1 DetallePedidos.IdDetalleLMateriales
														From DetallePedidos
														Where DetallePedidos.IdDetallePedido=dr.IdDetallePedido)))
 End as [L.Materiales],
 Obras.NumeroObra as [Obra],
 Requerimientos.NumeroRequerimiento as [RM],
 DetalleRequerimientos.NumeroItem as [Item RM],
 Case 	When Pedidos.SubNumero is not null 
	Then Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+'/'+Convert(varchar,Pedidos.SubNumero)
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)
 End as [Pedido],
 DetallePedidos.NumeroItem as [Item pedido],
 Rubros.Descripcion as [Rubro],
 E1.Nombre as [Solicito],
 A1.Descripcion as [Cuenta],
 dr.CostoUnitario*dr.CotizacionMoneda as [Costo],
 dr.Cantidad*dr.CostoUnitario*dr.CotizacionMoneda as [TotalItem],
 (Select Top 1 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) 
  From DetalleComprobantesProveedores dcp
  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor 
  Where dcp.IdDetalleRecepcion=dr.IdDetalleRecepcion) as [Factura],
 (Select Top 1 cp.FechaComprobante
  From DetalleComprobantesProveedores dcp
  Left Outer Join ComprobantesProveedores cp On cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor 
  Where dcp.IdDetalleRecepcion=dr.IdDetalleRecepcion) as [FechaFactura],
 A2.Descripcion as [Cuenta de compra],
 DetalleRequerimientos.MoP as [MoP],
 DetalleRequerimientos.CodigoDistribucion as [CodigoDistribucion],
 E2.Nombre as [Realizo],
 Convert(varchar(4000),Recepciones.Observaciones) as [ObservacionesCabeza],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion]
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
	(@IdObra=-1 or @IdObra=dr.IdObra) and 
	(@IdArticulo=-1 or @IdArticulo=dr.IdArticulo) and 
	(@Numero=-1 or @Numero=Pedidos.NumeroPedido) and 
	(@IdProveedor=-1 or @IdProveedor=Recepciones.IdProveedor)  

UNION ALL

SELECT 
 'OTROS ING.' as [Tipo],
 Substring('00000000',1,8-Len(Convert(varchar,oia.NumeroOtroIngresoAlmacen)))+
	Convert(varchar,oia.NumeroOtroIngresoAlmacen) as [Recepcion],
 Null as [Nro.recep.alm.],
 Null as [Proveedor],
 Null as [Fecha necesidad],
 Null as [Fecha promesa],
 oia.FechaOtroIngresoAlmacen as [Fecha entrega],
 Null as [En termino (dias)],
 Null as [Fuera de termino (dias)],
 Articulos.Descripcion as [Material],
 Articulos.Codigo as [Codigo],
 Convert(varchar(4000),doia.Observaciones) as [Observaciones],
 Convert(varchar(4000),doia.Observaciones) as [Observaciones1],
 IsNull(doia.CantidadCC,doia.Cantidad) as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 Null as [L.Materiales],
 Obras.NumeroObra as [Obra],
 Null as [RM],
 Null as [Item RM],
 Null as [Pedido],
 Null as [Item pedido],
 Rubros.Descripcion as [Rubro],
 Null as [Solicito],
 A1.Descripcion as [Cuenta],
 Null as [Costo],
 Null as [TotalItem],
 Null as [Factura],
 Null as [FechaFactura],
 A2.Descripcion as [Cuenta],
 Null as [MoP],
 Null as [CodigoDistribucion],
 Empleados.Nombre as [Realizo],
 Convert(varchar(4000),oia.Observaciones) as [ObservacionesCabeza],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion]
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

ORDER BY [Fecha entrega], [Tipo] desc, [Nro.recep.alm.], [Item pedido]