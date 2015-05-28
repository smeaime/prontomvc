CREATE PROCEDURE [dbo].[Requerimientos_TX_PendientesPorRM1]

@TiposComprobante varchar(1),
@IdObra int = Null,
@PorPeriodo varchar(1) = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null

AS

SET @IdObra=IsNull(@IdObra,-1)
SET @PorPeriodo=IsNull(@PorPeriodo,'T')
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)

DECLARE @CantidadFirmasRM int, @LiberarCircuito varchar(2), @FirmasLiberacion int, @vector_X varchar(30), @vector_T varchar(30)

SET @CantidadFirmasRM=IsNull((Select Count(*) From DetalleAutorizaciones
				Left Outer Join Autorizaciones On DetalleAutorizaciones.IdAutorizacion=Autorizaciones.IdAutorizacion
				Where Autorizaciones.IdFormulario=3),0)
SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor) From Parametros2 Where Campo='AprobacionesRM'),1)
SET @LiberarCircuito=IsNull((Select Top 1 Valor From Parametros2 Where Campo='LiberarRMCircuito'),'NO')
SET @vector_X='0111111114111133'
SET @vector_T='0242139199E16300'

SELECT 
 DetReq.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 Requerimientos.FechaRequerimiento as [Fecha],
 Requerimientos.MontoPrevisto as [Monto prev.],
 Empleados.Nombre as [Comprador],
 Obras.NumeroObra+' '+Obras.Descripcion  as [Obra],
 DetReq.IdRequerimiento as [IdAux1],
 Requerimientos.Cumplido as [Cump.],
 DetReq.IdRequerimiento as [IdAux],
 Convert(varchar(2000),Requerimientos.Observaciones) as [Observaciones],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetReq.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=DetReq.IdRequerimiento) as [Fecha 2da.Firma],
 Sectores.Descripcion as [Sector],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Empleados ON Requerimientos.IdComprador = Empleados.IdEmpleado
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector = Sectores.IdSector
WHERE ((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	(Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO') and 
	(@TiposComprobante='T' or DetReq.Cumplido is null or (DetReq.Cumplido<>'SI' and DetReq.Cumplido<>'AN')) and 
	(@TiposComprobante='T' or Requerimientos.Cumplido is null or (Requerimientos.Cumplido<>'SI' and Requerimientos.Cumplido<>'AN')) and 
/*	 (@TiposComprobante='T' or DetReq.IdProveedor is null) AND 	*/
	(@TiposComprobante='T' or (DetReq.IdAproboAlmacen is not null or (Requerimientos.DirectoACompras is not null and Requerimientos.DirectoACompras='SI'))) and 
	(@LiberarCircuito='NO' or 
	 (@LiberarCircuito='SI' and IsNull((Select Count(*) From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.IdComprobante=Requerimientos.IdRequerimiento),0)>=@CantidadFirmasRM)) and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@PorPeriodo='T' or Requerimientos.FechaRequerimiento Between @FechaDesde And @FechaHasta) and 
	IsNull(Requerimientos.Confirmado,'SI')<>'NO' and 
	IsNull(DetReq.TipoDesignacion,'CMP')<>'S/D' and 
	IsNull(DetReq.TipoDesignacion,'CMP')<>'STK' and 
	IsNull(TiposCompra.Modalidad,'CN')<>'CO'
GROUP BY DetReq.IdRequerimiento,Requerimientos.NumeroRequerimiento,Requerimientos.FechaRequerimiento,
		Requerimientos.MontoPrevisto,Empleados.Nombre,Obras.NumeroObra,Requerimientos.Cumplido,Obras.Descripcion,
		Convert(varchar(2000),Requerimientos.Observaciones), TiposCompra.Descripcion, Sectores.Descripcion
ORDER BY Requerimientos.NumeroRequerimiento