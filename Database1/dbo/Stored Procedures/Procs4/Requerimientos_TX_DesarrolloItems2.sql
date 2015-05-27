
CREATE Procedure [dbo].[Requerimientos_TX_DesarrolloItems2]

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111111111111111133'
SET @vector_T='03940106E44102100414104055024500'

SELECT 
 _TempEstadoRMs.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero RM],
 _TempEstadoRMs.IdDetalleRequerimiento as [IdAux],
 Requerimientos.FechaRequerimiento as [Fecha],
 DetRM.NumeroItem as [Item],
 E1.Nombre as [Emitio],
 Requerimientos.Cumplido as [Cump.],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetRM.Observaciones as [Observaciones item],
 Requerimientos.Observaciones as [Observaciones grales.],
 DetRM.Cantidad as [Cant.],
 U1.Abreviatura as [Un.],
 DetRM.CodigoDistribucion as [Cod.Dist.],
 Case 	When (DetSM.IdEquipoDestino is not null or DetRM.IdEquipoDestino is not null) and IsNull(Requerimientos.TipoRequerimiento,'')<>'OT'
	 Then IsNull(Requerimientos.TipoRequerimiento,'')+' - '+
		Convert(varchar,IsNull((Select Top 1 A.NumeroInventario From Articulos A Where IsNull(DetSM.IdEquipoDestino,DetRM.IdEquipoDestino)=A.IdArticulo),''))
	When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST'
	 Then IsNull(Requerimientos.TipoRequerimiento,'')+' - '+
		Convert(varchar,IsNull((Select Top 1 OT.NumeroOrdenTrabajo From OrdenesTrabajo OT Where IsNull(DetSM.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo)=OT.IdOrdenTrabajo),''))
	When DetSM.IdOrdenTrabajo is not null
	 Then 'OT - '+Convert(varchar,IsNull((Select Top 1 OT.NumeroOrdenTrabajo From OrdenesTrabajo OT Where DetSM.IdOrdenTrabajo=OT.IdOrdenTrabajo),''))
	Else IsNull(Requerimientos.TipoRequerimiento,'')
 End as [Tipo Req.],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcionOrigen1)))+Convert(varchar,Recepciones.NumeroRecepcionOrigen1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcionOrigen2)))+Convert(varchar,Recepciones.NumeroRecepcionOrigen2) as [Remito],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2) as [Recepcion],
 Recepciones.FechaRecepcion as [Fecha recepcion],
 E2.Nombre as [Emitio recepcion],
 Recepciones.Observaciones as [Observaciones recepcion],
 IsNull(P1.RazonSocial,P2.RazonSocial) as [Proveedor], 
 ComprobantesProveedores.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,ComprobantesProveedores.NumeroComprobante1)))+Convert(varchar,ComprobantesProveedores.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,ComprobantesProveedores.NumeroComprobante2)))+Convert(varchar,ComprobantesProveedores.NumeroComprobante2) as [Comprobante],
 ComprobantesProveedores.FechaComprobante as [Fecha comp.], 
 Monedas.Abreviatura as [Moneda],
 Case When IsNull(DetCP.Cantidad,0)<>0 Then DetCP.Importe/DetCP.Cantidad Else Null End as [Costo un. s/iva],
 DetCP.Importe as [Costo total s/iva],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Nro. de salida],
 Case	When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
	When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
	When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
	Else SalidasMateriales.ClaveTipoSalida
 End as [Tipo de salida],
 SalidasMateriales.FechaSalidaMateriales as [Fecha salida],
 SalidasMateriales.Observaciones as [Observaciones salida],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM _TempEstadoRMs
LEFT OUTER JOIN DetalleRequerimientos DetRM ON DetRM.IdDetalleRequerimiento=_TempEstadoRMs.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetRM.IdRequerimiento=Requerimientos.IdRequerimiento
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Requerimientos.Aprobo
LEFT OUTER JOIN Unidades U1 ON U1.IdUnidad=DetRM.IdUnidad
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetRM.IdArticulo
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Articulos.IdCuentaCompras
LEFT OUTER JOIN DetalleRecepciones DetRE ON DetRE.IdDetalleRecepcion=_TempEstadoRMs.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=DetRE.IdRecepcion
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Recepciones.Realizo
LEFT OUTER JOIN DetalleComprobantesProveedores DetCP ON DetCP.IdDetalleComprobanteProveedor=_TempEstadoRMs.IdDetalleComprobanteProveedor
LEFT OUTER JOIN ComprobantesProveedores ON ComprobantesProveedores.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores P1 ON P1.IdProveedor=ComprobantesProveedores.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON P2.IdProveedor=ComprobantesProveedores.IdProveedorEventual
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=ComprobantesProveedores.IdMoneda
LEFT OUTER JOIN DetalleSalidasMateriales DetSM ON DetSM.IdDetalleSalidaMateriales=_TempEstadoRMs.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales=DetSM.IdSalidaMateriales
WHERE _TempEstadoRMs.IdDetalleRecepcion is not null or _TempEstadoRMs.IdDetalleComprobanteProveedor is not null or _TempEstadoRMs.IdDetalleSalidaMateriales is not null
ORDER BY Requerimientos.NumeroRequerimiento, DetRM.NumeroItem
