CREATE Procedure [dbo].[Requerimientos_TX_DadosPorCumplidos]

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111133'
SET @vector_T='02H1D1011110242108115100'

SELECT 
 DetReq.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 DetReq.NumeroItem as [Item],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetReq.Cantidad as [Cant.],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Un.],
 (Select Sum(IsNull(DetalleValesSalida.Cantidad,0)) 
	From DetalleValesSalida 
	Where DetalleValesSalida.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetalleValesSalida.Estado is null or DetalleValesSalida.Estado<>'AN')) as [Vales],
 (Select Sum(IsNull(DetallePedidos.Cantidad,0)) 
	From DetallePedidos 
	Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')) as [Cant.Ped.],
 (Select Sum(IsNull(DetalleRecepciones.CantidadCC,0)) 
	From DetalleRecepciones 
	Left Outer Join Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
	Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' and IsNull(Recepciones.IdProveedor,0)<>0) as [Recibido],
 Case When DetReq.TipoDesignacion='REC' 
	Then 
	 (Select Top 1
	  Case 	When Recepciones.SubNumero is not null 
		 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+Convert(varchar,Recepciones.SubNumero) ,1,20) 
		 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
	  End 
	  From DetalleRecepciones DetRec
	  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
	  Where DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' and IsNull(Recepciones.IdProveedor,0)<>0)
	Else Null
 End as [Recepcion],
 E2.Nombre as [Solicito],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 DetReq.FechaEntrega as [F.entrega],
 DetReq.Observaciones as [Observaciones item],
 E1.Nombre as [Dio por cumplido],
 E3.Nombre as [Autorizo dar por cumplido],
 DetReq.FechaDadoPorCumplido as [Fecha dio x cumpl.],
 DetReq.ObservacionesCumplido as [Observaciones dio x cumplido],
 Requerimientos.UsuarioAnulacion as [Anulo],
 Requerimientos.FechaAnulacion as [Fecha anulacion],
 Requerimientos.MotivoAnulacion as [Motivo de anulacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados E1 ON DetReq.IdDioPorCumplido = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON DetReq.IdAutorizoCumplido = E3.IdEmpleado
WHERE IsNull(Requerimientos.Confirmado,'SI')='SI' and 
	(DetReq.IdDioPorCumplido is not null or Requerimientos.UsuarioAnulacion is not null) and 
	Substring(IsNull(DetReq.ObservacionesCumplido,''),1,35)<>'Generacion de vales de almacen - RM'
ORDER BY Requerimientos.NumeroRequerimiento, DetReq.NumeroItem