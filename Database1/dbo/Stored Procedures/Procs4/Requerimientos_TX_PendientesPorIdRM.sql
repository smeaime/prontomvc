CREATE PROCEDURE [dbo].[Requerimientos_TX_PendientesPorIdRM]

@IdRequerimiento int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111101111111101111111133'
set @vector_T='0212100101100000499111900'

SELECT 
 DetReq.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 DetReq.NumeroItem as [Item],
 Requerimientos.MontoPrevisto as [Monto prev.],
 Empleados.Nombre as [Comprador],
 DetReq.IdDetalleLMateriales,
 LMateriales.NumeroLMateriales as [L.Mat.],
 DetalleLMateriales.NumeroItem as [Itm.LM],
 DetReq.Cantidad as [Cant.],
 (Select SUM(DetallePedidos.Cantidad) as [TCant]
	From DetallePedidos 
	Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
		(DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')) as [Pedido],
 (Select SUM(DetalleRecepciones.CantidadCC) as [TCant]
	From DetalleRecepciones 
	Left Outer Join Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
	Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
		(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [RM],
 (Select Unidades.Descripcion
	From Unidades
	Where Unidades.IdUnidad=DetReq.IdUnidad) as  [Unidad en],
 DetReq.Cantidad1 as [Med.1],
 DetReq.Cantidad2 as [Med.2],
 DetReq.IdArticulo,
 Articulos.Descripcion as Articulo,
 DetReq.FechaEntrega as [F.entrega],
 DetReq.IdDetalleRequerimiento as [IdAux],
 DetReq.IdRequerimiento,
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Requerimientos.IdSolicito) as [Solicito],
 CASE 	WHEN DetReq.IdDetalleLMateriales is not null 
	 THEN (Select Obras.NumeroObra From Obras Where Obras.IdObra=LMateriales.IdObra)
	 ELSE (Select Obras.NumeroObra From Obras Where Obras.IdObra=Requerimientos.IdObra)
 END as [Obra],
 CASE 	WHEN DetReq.IdDetalleLMateriales is not null 
	 THEN (Select Equipos.Tag From Equipos Where Equipos.IdEquipo=LMateriales.IdEquipo)
	 ELSE Null
 END as [Equipo],
 DetReq.IdDetalleRequerimiento as [IdAux1],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Empleados ON DetReq.IdComprador = Empleados.IdEmpleado
WHERE Requerimientos.IdRequerimiento=@IdRequerimiento and 
	Requerimientos.Aprobo is not null AND  (DetReq.Cumplido is null or DetReq.Cumplido<>'SI') AND 
	(Requerimientos.Cumplido is null or Requerimientos.Cumplido<>'SI') AND 
	(Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO') AND 
	(NOT EXISTS (Select * From DetallePedidos Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) OR
	(Select SUM(DetallePedidos.Cantidad)
		From DetallePedidos 
		Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
			(DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN'))<DetReq.Cantidad) AND 
	(NOT EXISTS (Select * From DetalleRecepciones Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) OR
	(Select SUM(DetalleRecepciones.CantidadCC)
		From DetalleRecepciones 
		Left Outer Join Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
		Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
			(Recepciones.Anulada is null or Recepciones.Anulada<>'SI'))<DetReq.Cantidad)
ORDER BY Requerimientos.NumeroRequerimiento