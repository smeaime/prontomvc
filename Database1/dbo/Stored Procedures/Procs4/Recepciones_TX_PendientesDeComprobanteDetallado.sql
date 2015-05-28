CREATE PROCEDURE [dbo].[Recepciones_TX_PendientesDeComprobanteDetallado]

@IdProveedor int = Null

AS

SET @IdProveedor=IsNull(@IdProveedor,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111133'
SET @vector_T='05D24110022E200'

SELECT 
 DetRec.IdDetalleRecepcion,
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
	Convert(varchar,IsNull(Recepciones.SubNumero,0)) as [Comprobante],
 Proveedores.RazonSocial as [Proveedor],
 Recepciones.FechaRecepcion as [Fecha],
 Pedidos.NumeroPedido as [Pedido],
 Requerimientos.NumeroRequerimiento as [RM],
 Empleados.Nombre as [Realizo],
 DetPed.NumeroItem as [It.Ped.],
 DetRec.Cantidad as [Cant.],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetRec.CostoUnitario * IsNull(DetRec.CotizacionMoneda,1) as [Costo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Requerimientos ON Recepciones.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Acopios ON Recepciones.IdAcopio=Acopios.IdAcopio
LEFT OUTER JOIN Empleados ON Recepciones.Realizo=Empleados.IdEmpleado
WHERE (@IdProveedor=-1 or Recepciones.IdProveedor=@IdProveedor) and 
	IsNull(Recepciones.ProcesadoPorCPManualmente,'NO')<>'SI' and 
	IsNull(Recepciones.Anulada,'NO')<>'SI' and 
	Not Exists(Select Top 1 DetCP.IdDetalleComprobanteProveedor
			From DetalleComprobantesProveedores DetCP
			Where DetCP.IdDetalleRecepcion=DetRec.IdDetalleRecepcion) and 
	--Recepciones.IdPedido is not null and     Se elimino para consulta 1571
	Recepciones.IdProveedor is not null
ORDER BY Proveedores.RazonSocial,FechaRecepcion