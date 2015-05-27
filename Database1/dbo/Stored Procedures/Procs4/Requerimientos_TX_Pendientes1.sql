CREATE PROCEDURE [dbo].[Requerimientos_TX_Pendientes1]

@TiposComprobante varchar(1),
@IdObra int = Null,
@PorPeriodo varchar(1) = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null

AS

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @PorPeriodo=IsNull(@PorPeriodo,'T')
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)

DECLARE @CantidadFirmasRM int, @LiberarCircuito varchar(2), @FirmasLiberacion int, @ModeloConsulta varchar(2), @TriggerActivado varchar(2)

SET @CantidadFirmasRM=IsNull((Select Count(*) From DetalleAutorizaciones
								Left Outer Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
								Where Autorizaciones.IdFormulario=3),0)
SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor) From Parametros2 Where Campo='AprobacionesRM'),1)
SET @LiberarCircuito=IsNull((Select Top 1 Valor	From Parametros2 Where Campo='LiberarRMCircuito'),'NO')
SET @ModeloConsulta=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
							Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
							Where pic.Clave='Modelo de informe de requerimientos pendientes sin nota de pedido'),'')
/*
SET @TriggerActivado=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
							Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
							Where pic.Clave='Trigger activado para informe de requerimientos pendientes sin nota de pedido'),'')
*/

/*
Esto es para marcar los detalles de requerimiento que estan cumplidos por vales (STK), a medida que pase el tiempo hay que volver a correr es sql.

UPDATE DetalleRequerimientos
SET Cumplido='SI'
WHERE IsNull(Cumplido,'')<>'AN' and IsNull(Cumplido,'')<>'SI' and 
	IsNull((Select Sum(IsNull(DetalleValesSalida.Cantidad,0)) 
			From DetalleValesSalida 
			Where DetalleValesSalida.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimiento and 
					(DetalleValesSalida.Estado is null or DetalleValesSalida.Estado<>'AN')),0)>=DetalleRequerimientos.Cantidad
*/

CREATE TABLE #Auxiliar0 (IdDetalleRequerimiento INTEGER)
IF @TiposComprobante='P' --and @TriggerActivado='SI'
  BEGIN
	INSERT INTO #Auxiliar0 
	 SELECT IdDetalleRequerimiento
	 FROM DetalleRequerimientos
	 WHERE IsNull(DetalleRequerimientos.Cumplido,'')<>'SI' and IsNull(DetalleRequerimientos.Cumplido,'')<>'AN'
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar0 
	 SELECT DetReq.IdDetalleRequerimiento
	 FROM DetalleRequerimientos DetReq
  END

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleRequerimiento INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecibida NUMERIC(18,2),
			 CantidadVales NUMERIC(18,2),
			 CantidadEnStock NUMERIC(18,2),
			 IdAutorizacionPorComprobante INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetReq.IdDetalleRequerimiento,
  (Select Sum(IsNull(DetallePedidos.Cantidad,0)) 
	From DetallePedidos 
	Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')), 
  (Select Sum(IsNull(DetalleRecepciones.CantidadCC,0)) 
	From DetalleRecepciones 
	Left Outer Join Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
	Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')), 
  (Select Sum(IsNull(DetalleValesSalida.Cantidad,0)) 
	From DetalleValesSalida 
	Where DetalleValesSalida.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetalleValesSalida.Estado is null or DetalleValesSalida.Estado<>'AN')), 
  Case When IsNull(Articulos.RegistrarStock,'SI')='SI' 
	Then (Select Sum(IsNull(Stock.CantidadUnidades,0)) From Stock Where DetReq.IdArticulo=Stock.IdArticulo)
	Else Null
  End, 
  (Select Top 1 Aut.IdAutorizacionPorComprobante 
	From AutorizacionesPorComprobante Aut 
	Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetReq.IdRequerimiento)
 FROM #Auxiliar0
 LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = #Auxiliar0.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN TiposCompra ON TiposCompra.IdTipoCompra = Requerimientos.IdTipoCompra
 WHERE 
	((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	(@TiposComprobante='T' or DetReq.Cumplido is null or (DetReq.Cumplido<>'SI' and DetReq.Cumplido<>'AN')) and 
	(@TiposComprobante='T' or Requerimientos.Cumplido is null or (Requerimientos.Cumplido<>'SI' and Requerimientos.Cumplido<>'AN')) and 
/*	 (@TiposComprobante='T' or DetReq.IdProveedor is null) AND 	*/
	(@TiposComprobante='T' or (DetReq.IdAproboAlmacen is not null or (Requerimientos.DirectoACompras is not null and Requerimientos.DirectoACompras='SI'))) and 
	IsNull(Requerimientos.Confirmado,'SI')<>'NO' and 
	(@LiberarCircuito='NO' or 
	 (@LiberarCircuito='SI' and IsNull((Select Count(*) From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.IdComprobante=Requerimientos.IdRequerimiento),0)>=@CantidadFirmasRM)) and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@PorPeriodo='T' or Requerimientos.FechaRequerimiento Between @FechaDesde And @FechaHasta) and 
	IsNull(TiposCompra.Modalidad,'CN')<>'CO'

SET NOCOUNT ON

DECLARE @vector_X varchar(50),@vector_T varchar(50)
IF @ModeloConsulta='01'
  BEGIN
	SET @vector_X='01111111111101110111111111411111111111111133'
	SET @vector_T='02H003D99999999999499139999959E9939952944900'
  END
ELSE
	IF @ModeloConsulta='02'
	  BEGIN
		SET @vector_X='0111111111110111011111111141111111111133'
		SET @vector_T='02H0052E112204100E499101419955E16F455H00'
	  END
	ELSE
	  BEGIN
		SET @vector_X='01111111111101110111111111411111111111111133'
		SET @vector_T='02H003D11122299200499131419955E1634252299200'
	  END

IF @ModeloConsulta='02'
	SELECT 
	 #Auxiliar1.IdDetalleRequerimiento as [IdDetalleRequerimiento],
	 Requerimientos.NumeroRequerimiento as [Req.Nro.],
	 DetReq.NumeroItem as [Item],
	 DetReq.Cantidad as [Cant.],	 Unidades.Abreviatura as [Un.],
	 Requerimientos.FechaAprobacion as [Fecha libero],
	 A1.Codigo as [Codigo],
	 A1.Descripcion as [Articulo],
	 #Auxiliar1.CantidadPedida as [Cant.Ped.],
	 #Auxiliar1.CantidadRecibida as [Recibido],
	 #Auxiliar1.CantidadEnStock as [En stock],
	 A1.StockMinimo as [Stk.min.],
	 DetReq.IdDetalleLMateriales as [IdDetalleLMateriales],
	 DetReq.FechaEntrega as [F.entrega],
	 E2.Nombre as [Solicito],
	 Obras.NumeroObra+' '+Obras.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS as [Obra],
	 DetReq.IdArticulo as [IdArticulo],
	 TiposCompra.Descripcion as [Tipo compra],
	 DetReq.Observaciones as [Observaciones item], --Replace(Convert(varchar(1000),DetReq.Observaciones),'\','') as [Observaciones item],
	 DetReq.IdDetalleRequerimiento as [IdAux],
	 DetReq.IdRequerimiento as [IdRequerimiento],
	 Rubros.Descripcion as [Rubro],
	 Sectores.Descripcion as [Sector],
	 #Auxiliar1.CantidadVales as [Vales],
	 Requerimientos.MontoPrevisto as [Monto prev.],
	 E1.Nombre as [Comprador],
	 Equipos.Tag as [Equipo],
	 DetReq.IdDetalleRequerimiento as [IdAux1],
	 Cuentas.Descripcion as [Cuenta contable],
	 DetReq.Cumplido as [Cump.],
	 DetReq.FechaAsignacionComprador as [Fecha Asig.Comprador],
	 E3.Nombre as [2da.Firma],
	 Aut.FechaAutorizacion as [Fecha 2da.Firma],
	 IsNull(Requerimientos.TipoRequerimiento,'')+
		Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP' Then IsNull(' - '+A2.NumeroInventario,'')
			When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST' Then Convert(varchar,IsNull(' - '+ot.NumeroOrdenTrabajo,''))
			Else ''
		End as [OT/OP],
	 Requerimientos.MontoParaCompra as [Monto comp.],
	 Subrubros.Descripcion as [Subrubro],
	 DetReq.ObservacionesFirmante as [Observacion firmante],
	 Case When IsNull((Select Top 1 drls.Situacion From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=#Auxiliar1.IdDetalleRequerimiento Order By Fecha Desc),'A')='A' Then 'A' Else 'I' End as [Sit.],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN DetalleRequerimientos DetReq ON #Auxiliar1.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
	LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetReq.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetReq.IdEquipoDestino
	LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
	LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
	LEFT OUTER JOIN AutorizacionesPorComprobante Aut ON #Auxiliar1.IdAutorizacionPorComprobante = Aut.IdAutorizacionPorComprobante
	LEFT OUTER JOIN Empleados E1 ON DetReq.IdComprador = E1.IdEmpleado
	LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
	LEFT OUTER JOIN Empleados E3 ON Aut.IdAutorizo = E3.IdEmpleado
	LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
	LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
	LEFT OUTER JOIN Obras ON IsNull(Requerimientos.IdObra,LMateriales.IdObra) = Obras.IdObra
	LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
	LEFT OUTER JOIN Sectores ON Requerimientos.IdSector = Sectores.IdSector
	LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
	LEFT OUTER JOIN Rubros ON Rubros.IdRubro = A1.IdRubro
	LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro = A1.IdSubrubro
	WHERE IsNull(DetReq.TipoDesignacion,'CMP')<>'S/D' and 
		(IsNull(DetReq.TipoDesignacion,'CMP')<>'STK' or (IsNull(DetReq.TipoDesignacion,'CMP')='STK' and IsNull(#Auxiliar1.CantidadPedida,0)>0 and DetReq.Cantidad>IsNull(#Auxiliar1.CantidadPedida,0))) and 
		DetReq.Cantidad>IsNull(#Auxiliar1.CantidadVales,0) and 
		IsNull(TiposCompra.Modalidad,'CN')<>'CO'
	ORDER BY Requerimientos.NumeroRequerimiento, DetReq.NumeroItem
ELSE
	SELECT 
	 #Auxiliar1.IdDetalleRequerimiento as [IdDetalleRequerimiento],
	 Requerimientos.NumeroRequerimiento as [Req.Nro.],
	 DetReq.NumeroItem as [Item],
	 DetReq.Cantidad as [Cant.],	 Unidades.Abreviatura as [Un.],
	 A1.Codigo as [Codigo],
	 A1.Descripcion as [Articulo],
	 #Auxiliar1.CantidadPedida as [Cant.Ped.],
	 #Auxiliar1.CantidadRecibida as [Recibido],
	 #Auxiliar1.CantidadVales as [Vales],
	 Requerimientos.MontoPrevisto as [Monto prev.],
	 E1.Nombre as [Comprador],
	 DetReq.IdDetalleLMateriales as [IdDetalleLMateriales],
	 LMateriales.NumeroLMateriales as [L.Mat.],
	 DetalleLMateriales.NumeroOrden as [Itm.LM],
	 #Auxiliar1.CantidadEnStock as [En stock],
	 DetReq.IdArticulo as [IdArticulo],
	 A1.StockMinimo as [Stk.min.],
	 DetReq.FechaEntrega as [F.entrega],
	 DetReq.IdDetalleRequerimiento as [IdAux],
	 DetReq.IdRequerimiento as [IdRequerimiento],
	 E2.Nombre as [Solicito],
	 Obras.NumeroObra+' '+Obras.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS as [Obra],
	 Equipos.Tag as [Equipo],
	 Cuentas.Descripcion as [Cuenta contable],
	 DetReq.Cumplido as [Cump.],
	 DetReq.Observaciones as [Observaciones],
	 DetReq.IdDetalleRequerimiento as [IdAux1],
	 DetReq.Observaciones as [Observaciones item], --Replace(Convert(varchar(1000),DetReq.Observaciones),'\','') as [Observaciones item],
	 DetReq.FechaAsignacionComprador as [Fec.Asig.Comprador],
	 TiposCompra.Descripcion as [Tipo compra],
	 E3.Nombre as [2da.Firma],
	 Aut.FechaAutorizacion as [Fecha 2da.Firma],
	 Sectores.Descripcion as [Sector],
	 IsNull(Requerimientos.TipoRequerimiento,'')+
		Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP' Then IsNull(' - '+A2.NumeroInventario,'')
			When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST' Then Convert(varchar,IsNull(' - '+ot.NumeroOrdenTrabajo,''))
			Else ''
		End as [OT/OP],
	 Requerimientos.MontoParaCompra as [Monto comp.],
	 Requerimientos.FechaAprobacion as [Fecha libero],
	 Rubros.Descripcion as [Rubro],
	 Subrubros.Descripcion as [Subrubro],
	 E1.Nombre as [Comprador],
	 DetReq.FechaAsignacionComprador as [Fecha Asig.Comprador],
	 DetReq.ObservacionesFirmante as [Observacion firmante],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN DetalleRequerimientos DetReq ON #Auxiliar1.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
	LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetReq.IdArticulo
	LEFT OUTER JOIN Articulos A2 ON A2.IdArticulo = DetReq.IdEquipoDestino
	LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
	LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
	LEFT OUTER JOIN AutorizacionesPorComprobante Aut ON #Auxiliar1.IdAutorizacionPorComprobante = Aut.IdAutorizacionPorComprobante
	LEFT OUTER JOIN Empleados E1 ON DetReq.IdComprador = E1.IdEmpleado
	LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
	LEFT OUTER JOIN Empleados E3 ON Aut.IdAutorizo = E3.IdEmpleado
	LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
	LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
	LEFT OUTER JOIN Obras ON IsNull(Requerimientos.IdObra,LMateriales.IdObra) = Obras.IdObra
	LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
	LEFT OUTER JOIN Sectores ON Requerimientos.IdSector = Sectores.IdSector
	LEFT OUTER JOIN OrdenesTrabajo ot ON ot.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
	LEFT OUTER JOIN Rubros ON Rubros.IdRubro = A1.IdRubro
	LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro = A1.IdSubrubro
	WHERE IsNull(DetReq.TipoDesignacion,'CMP')<>'S/D' and 
		(IsNull(DetReq.TipoDesignacion,'CMP')<>'STK' or (IsNull(DetReq.TipoDesignacion,'CMP')='STK' and IsNull(#Auxiliar1.CantidadPedida,0)>0 and DetReq.Cantidad>IsNull(#Auxiliar1.CantidadPedida,0))) and 
		DetReq.Cantidad>IsNull(#Auxiliar1.CantidadVales,0) and 
		IsNull(TiposCompra.Modalidad,'CN')<>'CO'
	ORDER BY Requerimientos.NumeroRequerimiento, DetReq.NumeroItem

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1