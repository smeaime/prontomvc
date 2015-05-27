
CREATE PROCEDURE [dbo].[Requerimientos_TX_PendientesPorSolicitud]

@IdSector int = Null

AS

IF @IdSector is null
	SET @IdSector=-1

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='0111111111111111133'
Set @vector_T='0290020222F40020300'

SELECT 
 DetReq.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 DetReq.IdDetalleRequerimiento as [IdAux],
 DetReq.NumeroItem as [Item],
 Empleados.Nombre as [Comprador],
 DetReq.Cantidad as [Cant.Req.],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as  [Unid.],
 (Select SUM(DetSol.Cantidad) 
	From DetalleSolicitudesCompra DetSol 
	Where DetSol.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) 
	as [Cant.Sol.],
 (Select SUM(DetallePedidos.Cantidad) 
	From DetallePedidos 
	Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
		(DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')) 
	as [Cant.Ped.],
 (Select SUM(DetalleRecepciones.CantidadCC) 
	From DetalleRecepciones 
	Left Outer Join Recepciones On Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
	Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and 
		(Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) 
	as [Recibido],
 Articulos.Descripcion as Articulo,
 DetReq.FechaEntrega as [F.entrega],
 (Select Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=Requerimientos.IdSolicito) as [Solicito],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 Cuentas.Descripcion as [Cuenta contable],
 DetReq.Cumplido as [Cump.],
 DetReq.Observaciones as [Observaciones item],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados ON DetReq.IdComprador = Empleados.IdEmpleado
LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
WHERE Requerimientos.Aprobo is not null and  
	(DetReq.Cumplido is null or (DetReq.Cumplido<>'SI' and DetReq.Cumplido<>'AN')) and 
	(Requerimientos.Cumplido is null or (Requerimientos.Cumplido<>'SI' and Requerimientos.Cumplido<>'AN')) and 
/*	(@TiposComprobante='T' or DetReq.IdProveedor is null) AND 	*/
	(DetReq.IdAproboAlmacen is not null or (Requerimientos.DirectoACompras is not null and Requerimientos.DirectoACompras='SI')) and 
	(Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO') and 
	DetReq.Cantidad - Isnull((Select Sum(DetSol.Cantidad) 
				From DetalleSolicitudesCompra DetSol 
				Where DetSol.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) ,0)>0 and 
	(@IdSector=-1 or Requerimientos.IdSector=@IdSector)
ORDER BY Requerimientos.NumeroRequerimiento,DetReq.NumeroItem
