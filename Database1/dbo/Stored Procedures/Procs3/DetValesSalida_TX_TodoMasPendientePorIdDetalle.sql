CREATE PROCEDURE [dbo].[DetValesSalida_TX_TodoMasPendientePorIdDetalle]

@IdDetalleValeSalida int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdDetalleValeSalida INTEGER,
			 Entregado NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetSal.IdDetalleValeSalida,
  SUM(DetSal.Cantidad) 
 FROM DetalleSalidasMateriales DetSal
 LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and DetSal.IdDetalleValeSalida is not null
 GROUP BY DetSal.IdDetalleValeSalida

SET NOCOUNT OFF

SELECT
 DetVal.IdDetalleValeSalida,
 DetVal.IdValeSalida,
 DetVal.IdArticulo,
 DetVal.Partida,
 DetVal.Cantidad,
 DetVal.IdUnidad,
 DetVal.Estado,
 DetVal.Cumplido,
 IsNull(DetReq.IdEquipoDestino,DetVal.IdEquipoDestino) as [IdEquipoDestino],
 DetVal.IdDetalleSolicitudEntrega,
 DetVal.IdDetalleRequerimiento,
 #Auxiliar1.Entregado as [Entregado],
 Case When #Auxiliar1.Entregado is not null Then DetVal.Cantidad-#Auxiliar1.Entregado Else DetVal.Cantidad End as [Pendiente],
 Articulos.IdUbicacionStandar,
 IsNull((Select Top 1 DetRec.CostoUnitario From DetalleRecepciones DetRec
			Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
			Where DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' 
			Order By Recepciones.FechaRecepcion Desc, Recepciones.NumeroRecepcionAlmacen Desc),0) as [CostoRecepcion],
 IsNull((Select Top 1 IsNull(DetRec.IdMoneda,1) From DetalleRecepciones DetRec
			Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
			Where DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' 
			Order By Recepciones.FechaRecepcion Desc, Recepciones.NumeroRecepcionAlmacen Desc) ,1) as [IdMonedaRecepcion],
 DetReq.Observaciones as [ObservacionesRequerimiento],
 Requerimientos.IdOrdenTrabajo as [IdOrdenTrabajo],
 OrdenesTrabajo.NumeroOrdenTrabajo as [NumeroOrdenTrabajo],
 OrdenesTrabajo.FechaFinalizacion as [FechaFinalizacion]
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN #Auxiliar1 ON DetVal.IdDetalleValeSalida= #Auxiliar1.IdDetalleValeSalida
LEFT OUTER JOIN Articulos ON DetVal.IdArticulo= Articulos.IdArticulo
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetVal.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
LEFT OUTER JOIN OrdenesTrabajo ON OrdenesTrabajo.IdOrdenTrabajo = Requerimientos.IdOrdenTrabajo
WHERE DetVal.IdDetalleValeSalida=@IdDetalleValeSalida

DROP TABLE #Auxiliar1
