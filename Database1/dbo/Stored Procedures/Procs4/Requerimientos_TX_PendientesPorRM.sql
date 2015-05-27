

CREATE PROCEDURE [dbo].[Requerimientos_TX_PendientesPorRM]

AS

DECLARE @FirmasLiberacion int
SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor)
				From Parametros2
				Where Campo='AprobacionesRM'),1)

Declare @vector_X varchar(50),@vector_T varchar(50),@TiposComprobante varchar(1)
Set @TiposComprobante=' '
Set @vector_X='011111111133'
Set @vector_T='024211491900'

SELECT 
 DetReq.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 Requerimientos.FechaRequerimiento as [Fecha],
 Requerimientos.MontoPrevisto as [Monto prev.],
 Empleados.Nombre as [Comprador],
 LMateriales.NumeroLMateriales as [L.Mat.],
 Obras.NumeroObra as [Obra],
 DetReq.IdRequerimiento,
 Requerimientos.Cumplido as [Cump.],
 DetReq.IdRequerimiento as [IdAux],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Empleados ON Requerimientos.IdComprador = Empleados.IdEmpleado
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
WHERE 
	((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	(Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO') AND 
	(@TiposComprobante='T' or DetReq.Cumplido is null or (DetReq.Cumplido<>'SI' and DetReq.Cumplido<>'AN')) AND 
	(@TiposComprobante='T' or Requerimientos.Cumplido is null or (Requerimientos.Cumplido<>'SI' and Requerimientos.Cumplido<>'AN')) AND 
/*	 (@TiposComprobante='T' or DetReq.IdProveedor is null) AND 	*/
	(@TiposComprobante='T' or DetReq.IdAproboAlmacen is not null)
GROUP BY DetReq.IdRequerimiento,Requerimientos.NumeroRequerimiento,Requerimientos.FechaRequerimiento,Requerimientos.MontoPrevisto,Empleados.Nombre,LMateriales.NumeroLMateriales,Obras.NumeroObra,Requerimientos.Cumplido
ORDER BY Requerimientos.NumeroRequerimiento

