

CREATE PROCEDURE [dbo].[Requerimientos_TX_Pendientes]

AS

DECLARE @FirmasLiberacion int
SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor)
				From Parametros2
				Where Campo='AprobacionesRM'),1)

Declare @vector_X varchar(50),@vector_T varchar(50),@TiposComprobante varchar(1)
Set @TiposComprobante=' '
Set @vector_X='01111101111110111111111114133'
Set @vector_T='02033100100000049913111419900'

SELECT 
 DetReq.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 DetReq.NumeroItem as [Item],
 Requerimientos.MontoPrevisto as [Monto prev.],
 Requerimientos.MontoParaCompra as [Monto comp.],
 Empleados.Nombre as [Comprador],
 DetReq.IdDetalleLMateriales,
 LMateriales.NumeroLMateriales as [L.Mat.],
 DetalleLMateriales.NumeroOrden as [Itm.LM],
 DetReq.Cantidad as [Cant.],
 (Select Unidades.Descripcion
	From Unidades
	Where Unidades.IdUnidad=DetReq.IdUnidad) as [Unidad en],
 DetReq.Cantidad1 as [Med.1],
 DetReq.Cantidad2 as [Med.2],
 DetReq.IdArticulo,
 Articulos.Descripcion as Articulo,
 DetReq.FechaEntrega as [F.entrega],
 DetReq.IdDetalleRequerimiento as [IdAux],
 DetReq.IdRequerimiento,
 (Select Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=Requerimientos.IdSolicito) as [Solicito],
 CASE 	WHEN DetReq.IdDetalleLMateriales is not null 
	 THEN (Select Obras.NumeroObra From Obras Where Obras.IdObra=LMateriales.IdObra)
	 ELSE (Select Obras.NumeroObra From Obras Where Obras.IdObra=Requerimientos.IdObra)
 END as [Obra],
 CASE 	WHEN DetReq.IdDetalleLMateriales is not null 
	 THEN (Select Equipos.Tag From Equipos Where Equipos.IdEquipo=LMateriales.IdEquipo)
	 ELSE Null
 END as [Equipo],
 (Select SUM(DetallePedidos.Cantidad)
  From DetallePedidos 
  Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
	(DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')) as [Cant.Ped.],
 (Select SUM(DetalleRecepciones.CantidadCC)
  From DetalleRecepciones 
  Left Outer Join Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
  Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
	(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [RM],
 Cuentas.Descripcion as [Cuenta contable],
 DetReq.Cumplido as [Cump.],
 DetReq.Observaciones,
 DetReq.IdDetalleRequerimiento as [IdAux1],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Empleados ON DetReq.IdComprador = Empleados.IdEmpleado
LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
WHERE 
	((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	(@TiposComprobante='T' or DetReq.Cumplido is null or (DetReq.Cumplido<>'SI' and DetReq.Cumplido<>'AN')) AND 
	(@TiposComprobante='T' or Requerimientos.Cumplido is null or (Requerimientos.Cumplido<>'SI' and Requerimientos.Cumplido<>'AN')) AND 
/*	 (@TiposComprobante='T' or DetReq.IdProveedor is null) AND 	*/
	(@TiposComprobante='T' or DetReq.IdAproboAlmacen is not null) AND 
	(Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO')
ORDER BY Requerimientos.NumeroRequerimiento,DetReq.NumeroItem

