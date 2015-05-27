CREATE PROCEDURE [dbo].[Requerimientos_TX_PendientesPlaneamiento]

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

DECLARE @CantidadFirmasRM int, @LiberarCircuito varchar(2), @FirmasLiberacion int, @vector_X varchar(50), @vector_T varchar(50)

SET @CantidadFirmasRM=IsNull((Select Count(*) From DetalleAutorizaciones
				Left Outer Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
				Where Autorizaciones.IdFormulario=3),0)
SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor) From Parametros2 Where Campo='AprobacionesRM'),1)
SET @LiberarCircuito=IsNull((Select Top 1 Valor	From Parametros2 Where Campo='LiberarRMCircuito'),'NO')

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleRequerimiento INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecibida NUMERIC(18,2),
			 CantidadVales NUMERIC(18,2),
			 CantidadEnStock NUMERIC(18,2),
			 IdAutorizacionPorComprobante INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleRequerimiento) ON [PRIMARY]
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
  (Select Top 1 Aut.IdAutorizacionPorComprobante From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetReq.IdRequerimiento)
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
 WHERE 	((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	(@TiposComprobante='T' or DetReq.Cumplido is null or (DetReq.Cumplido<>'SI' and DetReq.Cumplido<>'AN')) and 
	(@TiposComprobante='T' or Requerimientos.Cumplido is null or (Requerimientos.Cumplido<>'SI' and Requerimientos.Cumplido<>'AN')) and 
/*	 (@TiposComprobante='T' or DetReq.IdProveedor is null) AND 	*/
	(@TiposComprobante='T' or (DetReq.IdAproboAlmacen is not null or (Requerimientos.DirectoACompras is not null and Requerimientos.DirectoACompras='SI'))) and 
	IsNull(Requerimientos.Confirmado,'SI')<>'NO' and 
	(@LiberarCircuito='NO' or (@LiberarCircuito='SI' and IsNull((Select Count(*) From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.IdComprobante=Requerimientos.IdRequerimiento),0)>=@CantidadFirmasRM)) and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@PorPeriodo='T' or Requerimientos.FechaRequerimiento Between @FechaDesde And @FechaHasta) and 
	IsNull(TiposCompra.Modalidad,'CN')<>'CO'

SET NOCOUNT ON

SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor )From Parametros2 Where Campo='AprobacionesRM'),1)
SET @vector_X='01111111111101105111111111133'
SET @vector_T='03E12114214002108412221199500'

SELECT 
 DetReq.IdDetalleRequerimiento,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetReq.Cantidad as [Cant.],
 Unidades.Abreviatura as  [Unidad en],
 DetReq.Cantidad1 as [Med.1],
 DetReq.Cantidad2 as [Med.2],
 Obras.NumeroObra as [Obra],
/* Equipos.Tag as [Equipo], */
 'RM' as [Cpte.tipo],
 Requerimientos.NumeroRequerimiento as [Nro.],
 Requerimientos.FechaRequerimiento as [F.cpte.],
 DetReq.NumeroItem as [Item],
 DetReq.IdDetalleLMateriales,
 LMateriales.NumeroLMateriales as [L.Mat.nro.],
 DetalleLMateriales.NumeroOrden as [Itm.LM],
 DetReq.IdArticulo,
 DetReq.Observaciones,
 DetReq.FechaEntrega as [F.necesidad],
 E2.Nombre as [Solicito],
/*
 (Select SUM(DetalleReservas.CantidadUnidades) 
	From DetalleReservas 
	Where DetalleReservas.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) 
	as [Reservado],
*/
 Case When IsNull(Articulos.RegistrarStock,'SI')='SI' Then IsNull(#Auxiliar1.CantidadEnStock,0) Else Null End as [En stock],
 IsNull(#Auxiliar1.CantidadPedida,0) as [Cant.Ped.],
 IsNull(#Auxiliar1.CantidadRecibida,0) as [Recibido],
 DetReq.Cumplido as [Cump.],
 E1.Nombre as [Comprador asignado],
 DetReq.IdDetalleRequerimiento as [IdAux],
 DetReq.IdRequerimiento,
 DetReq.FechaAsignacionComprador as [Fec.Asig.Comprador],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Empleados E1 ON DetReq.IdComprador = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetReq.IdUnidad
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
WHERE 	((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	DetReq.IdProveedor is null and 
	IsNull(DetReq.Cumplido,'NO')<>'AN' and  IsNull(Requerimientos.Cumplido,'NO')<>'AN' and 
	((IsNull(DetReq.TipoDesignacion,'CMP')='STK' and IsNull(DetReq.Recepcionado,'NO')<>'SI') or (IsNull(DetReq.Cumplido,'NO')<>'SI' and  IsNull(Requerimientos.Cumplido,'NO')<>'SI')) and 
	IsNull(Requerimientos.Confirmado,'SI')<>'NO' and 
	IsNull(DetReq.TipoDesignacion,'CMP')<>'S/D' and 
	(IsNull(DetReq.TipoDesignacion,'CMP')<>'STK' or (IsNull(DetReq.TipoDesignacion,'CMP')='STK' and IsNull(#Auxiliar1.CantidadPedida,0)>0 and DetReq.Cantidad>IsNull(#Auxiliar1.CantidadPedida,0))) and
	DetReq.Cantidad>IsNull(#Auxiliar1.CantidadVales,0) and IsNull(DetReq.IdDioPorCumplido,0)=0 and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@PorPeriodo='T' or Requerimientos.FechaRequerimiento Between @FechaDesde And @FechaHasta) and 
	IsNull(TiposCompra.Modalidad,'CN')<>'CO'

--	 (@TiposComprobante='T' or 
--	  (DetReq.IdAproboAlmacen is not null or (Requerimientos.DirectoACompras is not null and Requerimientos.DirectoACompras='SI'))) and 

UNION ALL

SELECT 
 DetAco.IdDetalleAcopios,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetAco.Cantidad as [Cant.],
 (SELECT Unidades.Abreviatura FROM Unidades WHERE Unidades.IdUnidad=DetAco.IdUnidad) as  [Unidad en],
 DetAco.Cantidad1 as [Med.1],
 DetAco.Cantidad2 as [Med.2],
 Obras.NumeroObra as [Obra],
/* Equipos.Tag as [Equipo], */
 'LA' as [Cpte.tipo],
 Acopios.NumeroAcopio as [Nro.],
 Acopios.Fecha as [F.cpte.],
 DetAco.NumeroItem as [Item],
 Null,
 Null,
 Null,
 DetAco.IdArticulo,
 DetAco.Observaciones,
 DetAco.FechaNecesidad as [F.necesidad],
 Null,
 (SELECT SUM(DetalleReservas.CantidadUnidades) 
	FROM DetalleReservas 
	WHERE DetalleReservas.IdDetalleAcopios=DetAco.IdDetalleAcopios) as [Reservado],
 (SELECT SUM(DetallePedidos.Cantidad)
	FROM DetallePedidos 
	WHERE DetallePedidos.IdDetalleAcopios=DetAco.IdDetalleAcopios and (DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')) as [Cant.Ped.],
 (SELECT SUM(DetalleRecepciones.CantidadCC) 
	FROM DetalleRecepciones 
	WHERE DetalleRecepciones.IdDetalleAcopios=DetAco.IdDetalleAcopios) as [Recibido],
 DetAco.Cumplido as [Cump.],
 Empleados.Nombre as [Comprador asignado],
 DetAco.IdDetalleAcopios as [IdAux],
 DetAco.IdAcopio,
 Null as [Fec.Asig.Comprador],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Articulos ON DetAco.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Acopios ON DetAco.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN Obras ON Acopios.IdObra=Obras.IdObra
LEFT OUTER JOIN Equipos ON DetAco.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Cuentas ON DetAco.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Empleados ON DetAco.IdComprador = Empleados.IdEmpleado
WHERE Acopios.Aprobo is not null AND 
	 (@TiposComprobante='T' or DetAco.Cumplido is null or (DetAco.Cumplido<>'SI' and DetAco.Cumplido<>'AN')) AND 
	 (@TiposComprobante='T' or DetAco.IdProveedor is null) AND
	 (@TiposComprobante='T' or DetAco.IdAproboAlmacen is not null)

ORDER BY [Nro.],[Item]

DROP TABLE #Auxiliar1