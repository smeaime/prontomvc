CREATE  Procedure [dbo].[SalidasMateriales_TX_EntreFechas]

@Desde datetime,
@Hasta datetime,
@IdObra int,
@IdArticulo int = Null

AS 

SET @IdArticulo=IsNull(@IdArticulo,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111111111133'
SET @vector_T='034003E30033042F123F22300'

SELECT 
 DetSal.IdDetalleSalidaMateriales,
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [Nro. de salida],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 DetSal.Cantidad as [Cant.],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Un.],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Requerimientos.NumeroRequerimiento as [Nro.Req.],
 DetReq.NumeroItem as [Item],
 DetReq.CodigoDistribucion as [Cod.Dist.],
 DetSal.CostoUnitario*IsNull(DetSal.CotizacionMoneda,1) as [Costo Un.],
 DetSal.Cantidad*DetSal.CostoUnitario*IsNull(DetSal.CotizacionMoneda,1) as [Costo Total],
 Case 	When (DetSal.IdEquipoDestino is not null or DetReq.IdEquipoDestino is not null) and IsNull(Requerimientos.TipoRequerimiento,'')<>'OT'
	 Then IsNull(Requerimientos.TipoRequerimiento,'')+' - '+
		Convert(varchar,IsNull((Select Top 1 A.NumeroInventario From Articulos A Where IsNull(DetSal.IdEquipoDestino,DetReq.IdEquipoDestino)=A.IdArticulo),''))
	When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST'
	 Then IsNull(Requerimientos.TipoRequerimiento,'')+' - '+
		Convert(varchar,IsNull((Select Top 1 OT.NumeroOrdenTrabajo From OrdenesTrabajo OT Where IsNull(DetSal.IdOrdenTrabajo,Requerimientos.IdOrdenTrabajo)=OT.IdOrdenTrabajo),''))
	When DetSal.IdOrdenTrabajo is not null
	 Then 'OT - '+Convert(varchar,IsNull((Select Top 1 OT.NumeroOrdenTrabajo From OrdenesTrabajo OT Where DetSal.IdOrdenTrabajo=OT.IdOrdenTrabajo),''))
	Else IsNull(Requerimientos.TipoRequerimiento,'')
 End as [Tipo Req.],
 Obras.NumeroObra as [Obra],
/*
 (Select Top 1 Proveedores.RazonSocial 
  From DetalleComprobantesProveedores DetCom
  Left Outer Join ComprobantesProveedores cp On DetCom.IdComprobanteProveedor = cp.IdComprobanteProveedor
  Left Outer Join Proveedores On cp.IdProveedor = Proveedores.IdProveedor
  Left Outer Join DetalleRecepciones DetRec ON DetCom.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
  Where DetCom.IdDetalleRecepcion is not null and 
	DetRec.IdDetalleRequerimiento=DetalleValesSalida.IdDetalleRequerimiento) as [Proveedor],
*/
 (Select Top 1 Proveedores.RazonSocial 
  From DetalleRecepciones DetRec  
  Left Outer Join Recepciones ON DetRec.IdRecepcion=Recepciones.IdRecepcion
  Left Outer Join Proveedores On Recepciones.IdProveedor = Proveedores.IdProveedor
  Where DetRec.IdDetalleRequerimiento=DetalleValesSalida.IdDetalleRequerimiento) as [Proveedor],
 (Select Top 1 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
  From DetalleComprobantesProveedores DetCom
  Left Outer Join ComprobantesProveedores cp On DetCom.IdComprobanteProveedor = cp.IdComprobanteProveedor
  Left Outer Join DetalleRecepciones DetRec ON DetCom.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
  Where DetCom.IdDetalleRecepcion is not null and DetRec.IdDetalleRequerimiento=DetalleValesSalida.IdDetalleRequerimiento) as [Comprobante],
 Cuentas.Descripcion as [Cuenta contable],
 Case	When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
	When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
	When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
	Else SalidasMateriales.ClaveTipoSalida
 End as [Tipo de salida],
 dod.Destino as [Etapa obra],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 DetSal.Partida as [Partida],
 DetSal.NumeroCaja as [Nro.Caja],
 (Select Top 1 Cuentas.Descripcion 
  From DetalleComprobantesProveedores DetCom
  Left Outer Join DetalleRecepciones DetRec ON DetCom.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
  Left Outer Join Cuentas ON Cuentas.IdCuenta = DetCom.IdCuenta
  Where DetCom.IdDetalleRecepcion is not null and DetRec.IdDetalleRequerimiento=DetalleValesSalida.IdDetalleRequerimiento) as [Cuenta comprobante],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN ValesSalida ON DetalleValesSalida.IdValeSalida = ValesSalida.IdValeSalida
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
LEFT OUTER JOIN Obras ON Obras.IdObra = DetSal.IdObra
LEFT OUTER JOIN DetalleObrasDestinos dod ON dod.IdDetalleObraDestino = DetSal.IdDetalleObraDestino
LEFT OUTER JOIN Ubicaciones ON DetSal.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta) and 
	(@IdObra=-1 or DetSal.IdObra=@IdObra) and 
	(@IdArticulo=-1 or DetSal.IdArticulo=@IdArticulo) 
ORDER BY SalidasMateriales.FechaSalidaMateriales, SalidasMateriales.NumeroSalidaMateriales