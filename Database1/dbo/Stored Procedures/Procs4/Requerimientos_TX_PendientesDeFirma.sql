CREATE PROCEDURE [dbo].[Requerimientos_TX_PendientesDeFirma]

@IdObra int = Null,
@PorPeriodo varchar(1) = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null

AS

SET @IdObra=IsNull(@IdObra,-1)
SET @PorPeriodo=IsNull(@PorPeriodo,'T')
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)

DECLARE @FirmasLiberacion int,  @vector_X varchar(50), @vector_T varchar(50)

SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor) From Parametros2 Where Campo='AprobacionesRM'),1)
SET @vector_X='011111111533'
SET @vector_T='052111000500'

SELECT 
 DetReq.IdDetalleRequerimiento,
 DetReq.FechaEntrega as [F.entrega],
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 DetReq.NumeroItem as [Item],
 DetReq.Cantidad as [Cant.],
 Unidades.Descripcion as [Unidad en],
 Articulos.Descripcion as Articulo,
 Empleados.Nombre as [Solicito],
 Case When DetReq.IdDetalleLMateriales is not null 
	 Then (Select (Obras.NumeroObra+' '+Obras.Descripcion) From Obras Where Obras.IdObra=LMateriales.IdObra)
	 Else (Select (Obras.NumeroObra+' '+Obras.Descripcion ) From Obras Where Obras.IdObra=Requerimientos.IdObra)
 End as [Obra],
 DetReq.Observaciones as [Observaciones item],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales = LMateriales.IdLMateriales
LEFT OUTER JOIN Empleados ON Requerimientos.IdSolicito = Empleados.IdEmpleado
WHERE 	((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	IsNull(DetReq.Cumplido,'NO')<>'SI' and IsNull(DetReq.Cumplido,'NO')<>'AN' and 
	IsNull(Requerimientos.Cumplido,'NO')<>'SI' and IsNull(Requerimientos.Cumplido,'NO')<>'AN' and 
	IsNull(Requerimientos.Confirmado,'SI')='SI' and 
	Not Exists(Select IdAutorizacionPorComprobante From AutorizacionesPorComprobante Where AutorizacionesPorComprobante.IdFormulario=3 and AutorizacionesPorComprobante.IdComprobante=DetReq.IdRequerimiento) and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@PorPeriodo='T' or Requerimientos.FechaRequerimiento Between @FechaDesde And @FechaHasta)
ORDER BY DetReq.FechaEntrega, Requerimientos.NumeroRequerimiento, DetReq.NumeroItem