CREATE PROCEDURE [dbo].[Pedidos_TX_DetPendientesTodos]

@Formato int = Null,
@IdProveedor int = Null,
@IdTransportista int = Null,
@IdLugarEntrega int = Null,
@IdObra int = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null,
@IdsTipoCompra varchar(1000) = Null,
@EstadoFirmas varchar(1) = Null

AS

SET NOCOUNT ON

DECLARE @vector_X varchar(50), @vector_T varchar(50), @IdProveedorTransporte int, @CantReg int, @TomarPedidosSinLiberar varchar(2), @FormatoProntoIni varchar(2)

SET @Formato=IsNull(@Formato,0)
SET @IdProveedor=IsNull(@IdProveedor,0)
SET @IdTransportista=IsNull(@IdTransportista,0)
SET @IdLugarEntrega=IsNull(@IdLugarEntrega,0)
SET @IdObra=IsNull(@IdObra,0)
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)
SET @IdsTipoCompra=IsNull(@IdsTipoCompra,'')
SET @EstadoFirmas=IsNull(@EstadoFirmas,'*')

SET @IdProveedorTransporte=IsNull((Select Top 1 IdProveedor From Transportistas Where IdTransportista=@IdTransportista),0)
SET @TomarPedidosSinLiberar=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Permitir emision de pedido sin liberar'),'')
SET @FormatoProntoIni=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Formato consulta de notas de pedidos pendientes de entrega'),'')
IF Len(@FormatoProntoIni)>0
	SET @Formato=Convert(int,@FormatoProntoIni)

CREATE TABLE #Auxiliar (IdProveedor INTEGER)
IF @IdProveedor>0
	INSERT INTO #Auxiliar 
	 SELECT IdProveedor FROM Proveedores WHERE IdProveedor=@IdProveedor
IF @IdProveedorTransporte>0
	INSERT INTO #Auxiliar 
	 SELECT IdProveedor FROM Proveedores WHERE IdProveedor=@IdProveedorTransporte

SET @CantReg=(Select Count(*) From #Auxiliar)

SET NOCOUNT OFF

IF @Formato=0
  BEGIN
	SET @vector_X='0111011111111111111111111111111111133'
	SET @vector_T='031400991142D2211111119211519E1651400'
	
	SELECT
	 DetPed.IdDetallePedido,
	 Case When Pedidos.SubNumero is not null Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4) Else str(Pedidos.NumeroPedido,8) End as [Pedido],
	 DetPed.NumeroItem as [Item],
	 Pedidos.FechaPedido as [Fecha],
	 Pedidos.IdProveedor,
	 Proveedores.RazonSocial as [Proveedor],
	 Proveedores.Telefono1,
	 Proveedores.Email,
	 E1.Nombre as [Comprador],
	 E2.Nombre as [Solicito RM],
	 DetPed.FechaEntrega as [F.entrega],
	 A1.Codigo as [Codigo],
	 A1.Descripcion as [Articulo],
	 DetalleRequerimientos.Observaciones as [Observacion item RM],
	 DetPed.Observaciones as [Observaciones item pedido],
	 DetPed.Cantidad as [Cant.],
	 (Select substring(Unidades.Descripcion,1,20) From Unidades Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
	 (Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec
	  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
	  Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [Entregado],
	 DetPed.Cantidad - Isnull((Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec 
					Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
					Where DetRec.IdDetallePedido=DetPed.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0) as [Pendiente],
	 DetPed.NumeroItem as [It.Ped],
	 Requerimientos.NumeroRequerimiento as [Nro.RM],
	 DetalleRequerimientos.NumeroItem as [It.RM],
	 DetPed.IdPedido,
	 DetPed.Cumplido as [Cump.],
	 Acopios.NumeroAcopio as [Nro.LA],
	 DetalleAcopios.NumeroItem as [It.LA],
	 Case When Acopios.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
		When Requerimientos.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
		Else Null
	 End as [Obra],
	 Equipos.Tag as [Equipo],
	 DetPed.IdDetallePedido as [IdAux],
	 TiposCompra.Descripcion as [Tipo compra],
	 (Select Top 1 Empleados.Nombre From Empleados 
	  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut 
					Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
						Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento)) as [2da.Firma],
	 (Select Top 1 Aut.FechaAutorizacion From AutorizacionesPorComprobante Aut 
	  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento) as [Fecha 2da.Firma],
	 DetalleRequerimientos.Observaciones as [Observacion item RM],
	 Monedas.Abreviatura as [Mon.],
	 IsNull(Requerimientos.TipoRequerimiento,'')+
		Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP' Then IsNull(' - '+A2.NumeroInventario,'')
			When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST' Then Convert(varchar,IsNull(' - '+ot.NumeroOrdenTrabajo,''))
			Else ''
		End as [OT/OP],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM DetallePedidos DetPed
	LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
	LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
	LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
	LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
	LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetPed.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetalleRequerimientos.IdEquipoDestino
	LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Pedidos.IdComprador
	LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
	LEFT OUTER JOIN DetalleLMateriales ON DetalleRequerimientos.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
	LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
	LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
	LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
	LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
	LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
	WHERE IsNull(DetPed.Cumplido,'')<>'SI' and IsNull(DetPed.Cumplido,'')<>'AN' and IsNull(Pedidos.Cumplido,'')<>'SI' and 
		(@CantReg=0 or Exists(Select Top 1 IdProveedor From #Auxiliar Where #Auxiliar.IdProveedor=Pedidos.IdProveedor)) and 
		(@TomarPedidosSinLiberar='SI' or Pedidos.Aprobo is not null) and 
		(@IdLugarEntrega<=0 or Pedidos.IdLugarEntrega=@IdLugarEntrega) and 
		(@EstadoFirmas='*' or (@EstadoFirmas='F' and IsNull(Pedidos.CircuitoFirmasCompleto,'')='SI') or (@EstadoFirmas='P' and IsNull(Pedidos.CircuitoFirmasCompleto,'')<>'SI'))
	ORDER By Pedidos.NumeroPedido,Pedidos.SubNumero,DetPed.NumeroItem
  END

IF @Formato=1
  BEGIN
	SET @vector_X='01110111111111111111111111111111111133'
	SET @vector_T='03H400999999E2111999999999999999461400'
	
	SELECT
	 DetPed.IdDetallePedido,
	 Case When Pedidos.SubNumero is not null Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4) Else str(Pedidos.NumeroPedido,8) End as [Pedido],
	 DetPed.NumeroItem as [Item],
	 Pedidos.FechaPedido as [Fecha],
	 Pedidos.IdProveedor,
	 Proveedores.RazonSocial as [Proveedor],
	 Proveedores.Telefono1,
	 Proveedores.Email,
	 Proveedores.Contacto,
	 E1.Nombre as [Comprador],
	 DetPed.FechaEntrega as [F.entrega1],
	 A1.Codigo as [Codigo1],
	 A1.Descripcion as [Articulo],
	 DetPed.Observaciones as [Observaciones],
	 DetPed.Cantidad - Isnull((Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec 
					Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
					Where DetRec.IdDetallePedido=DetPed.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0) as [Pendiente],
	 DetPed.Cantidad as [Cant.],
	 (Select substring(Unidades.Descripcion,1,20) From Unidades Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
	 DetPed.FechaEntrega as [F.entrega],
	 A1.Codigo as [Codigo],
	 DetPed.NumeroItem as [It.Ped],
	 Requerimientos.NumeroRequerimiento as [Nro.RM],
	 DetalleRequerimientos.NumeroItem as [It.RM],
	 DetPed.IdPedido,
	 DetPed.Cumplido as [Cump.],
	 Acopios.NumeroAcopio as [Nro.LA],
	 DetalleAcopios.NumeroItem as [It.LA],
	 Case When Acopios.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
		When Requerimientos.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
		Else Null
	 End as [Obra],
	 Equipos.Tag as [Equipo],
	 DetPed.IdDetallePedido as [IdAux],
	 TiposCompra.Descripcion as [Tipo compra],
	 (Select Top 1 Empleados.Nombre From Empleados 
	  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut 
					Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and 
						Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento)) as [2da.Firma],
	 (Select Top 1 Aut.FechaAutorizacion From AutorizacionesPorComprobante Aut 
	  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento) as [Fecha 2da.Firma],
	 DetPed.FechaEntrega as [F.entrega],
	 A1.Codigo as [Codigo1],
	 Monedas.Abreviatura as [Mon.],
	 IsNull(Requerimientos.TipoRequerimiento,'')+
		Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP' Then IsNull(' - '+A2.NumeroInventario,'')
			When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST' Then Convert(varchar,IsNull(' - '+ot.NumeroOrdenTrabajo,''))
			Else ''
		End as [OT/OP],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM DetallePedidos DetPed
	LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
	LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
	LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
	LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
	LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetPed.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetalleRequerimientos.IdEquipoDestino
	LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Pedidos.IdComprador
	LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
	LEFT OUTER JOIN DetalleLMateriales ON DetalleRequerimientos.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
	LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
	LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
	LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
	LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
	LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
	WHERE IsNull(DetPed.Cumplido,'')<>'SI' and IsNull(DetPed.Cumplido,'')<>'AN' and IsNull(Pedidos.Cumplido,'')<>'SI' and 
		(@CantReg=0 or Exists(Select Top 1 IdProveedor From #Auxiliar Where #Auxiliar.IdProveedor=Pedidos.IdProveedor)) and 
		(@TomarPedidosSinLiberar='SI' or Pedidos.Aprobo is not null) and 
		(@IdLugarEntrega<=0 or Pedidos.IdLugarEntrega=@IdLugarEntrega) and 
		(@EstadoFirmas='*' or (@EstadoFirmas='F' and IsNull(Pedidos.CircuitoFirmasCompleto,'')='SI') or (@EstadoFirmas='P' and IsNull(Pedidos.CircuitoFirmasCompleto,'')<>'SI'))
	ORDER By Pedidos.NumeroPedido,Pedidos.SubNumero,DetPed.NumeroItem
  END

IF @Formato=2
  BEGIN
	SET @vector_X='01111011111111111111111111111111111133'
	SET @vector_T='032140091142D2211111119299999E99999100'
	
	SELECT
	 DetPed.IdDetallePedido,
	 Case When Pedidos.SubNumero is not null Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4) Else str(Pedidos.NumeroPedido,8) End as [Pedido],
	 Case When Acopios.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
		When Requerimientos.IdObra is not null Then (Select Top 1 Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
		Else Null
	 End as [Obra],
	 DetPed.NumeroItem as [Item],
	 Pedidos.FechaPedido as [Fecha],
	 Pedidos.IdProveedor,
	 Proveedores.RazonSocial as [Proveedor],
	 Proveedores.Email,
	 E1.Nombre as [Comprador],
	 E2.Nombre as [Solicito RM],
	 DetPed.FechaEntrega as [F.entrega],
	 A1.Codigo as [Codigo],
	 A1.Descripcion as [Articulo],
	 DetalleRequerimientos.Observaciones as [Observacion item RM],
	 DetPed.Observaciones as [Observaciones item pedido],
	 DetPed.Cantidad as [Cant.],
	 (Select substring(Unidades.Descripcion,1,20) From Unidades Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
	 (Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec
	  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
	  Where DetPed.IdDetallePedido=DetRec.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [Entregado],
	 DetPed.Cantidad - Isnull((Select Sum(DetRec.Cantidad) From DetalleRecepciones DetRec 
					Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
					Where DetRec.IdDetallePedido=DetPed.IdDetallePedido and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0) as [Pendiente],
	 DetPed.NumeroItem as [It.Ped],
	 Requerimientos.NumeroRequerimiento as [Nro.RM],
	 DetalleRequerimientos.NumeroItem as [It.RM],
	 DetPed.IdPedido,
	 DetPed.Cumplido as [Cump.],
	 Acopios.NumeroAcopio as [Nro.LA],
	 DetalleAcopios.NumeroItem as [It.LA],
	 Null as [Obra1],
	 Equipos.Tag as [Equipo],
	 DetPed.IdDetallePedido as [IdAux],
	 TiposCompra.Descripcion as [Tipo compra],
	 (Select Top 1 Empleados.Nombre From Empleados 
	  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut 
					Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento)) as [2da.Firma],
	 (Select Top 1 Aut.FechaAutorizacion From AutorizacionesPorComprobante Aut 
	  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetalleRequerimientos.IdRequerimiento) as [Fecha 2da.Firma],
	 DetalleRequerimientos.Observaciones as [Observacion item RM],
	 Monedas.Abreviatura as [Mon.],
	 IsNull(Requerimientos.TipoRequerimiento,'')+
		Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP' Then IsNull(' - '+A2.NumeroInventario,'')
			When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST' Then Convert(varchar,IsNull(' - '+ot.NumeroOrdenTrabajo,''))
			Else ''
		End as [OT/OP],
	 Pedidos.CircuitoFirmasCompleto as [Firmas],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM DetallePedidos DetPed
	LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
	LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
	LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
	LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
	LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetPed.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetalleRequerimientos.IdEquipoDestino
	LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Pedidos.IdComprador
	LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
	LEFT OUTER JOIN DetalleLMateriales ON DetalleRequerimientos.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
	LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
	LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
	LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
	LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
	LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
	WHERE IsNull(DetPed.Cumplido,'')<>'SI' and IsNull(DetPed.Cumplido,'')<>'AN' and IsNull(Pedidos.Cumplido,'')<>'SI' and 
		(@CantReg=0 or Exists(Select Top 1 IdProveedor From #Auxiliar Where #Auxiliar.IdProveedor=Pedidos.IdProveedor)) and 
		(@TomarPedidosSinLiberar='SI' or Pedidos.Aprobo is not null) and 
		(@IdLugarEntrega<=0 or Pedidos.IdLugarEntrega=@IdLugarEntrega) and 
		(@IdObra<=0 or IsNull(Requerimientos.IdObra,Acopios.IdObra)=@IdObra) and 
		(@FechaDesde<=0 or Pedidos.FechaPedido Between @FechaDesde And @FechaHasta) and 
		(@IdsTipoCompra='' or Patindex('%('+Convert(varchar,IsNull(Requerimientos.IdTipoCompra,0))+')%', @IdsTipoCompra)<>0) and 
		(@EstadoFirmas='*' or (@EstadoFirmas='F' and IsNull(Pedidos.CircuitoFirmasCompleto,'')='SI') or (@EstadoFirmas='P' and IsNull(Pedidos.CircuitoFirmasCompleto,'')<>'SI'))
	ORDER By Pedidos.NumeroPedido,Pedidos.SubNumero,DetPed.NumeroItem
  END

DROP TABLE #Auxiliar