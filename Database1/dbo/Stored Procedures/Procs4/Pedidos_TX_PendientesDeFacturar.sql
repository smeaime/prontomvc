CREATE PROCEDURE [dbo].[Pedidos_TX_PendientesDeFacturar]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetallePedido INTEGER,
			 IdDetalleComprobanteProveedor INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetallePedido) ON [PRIMARY]

INSERT INTO #Auxiliar1
 SELECT IsNull(dcp.IdDetallePedido,dr.IdDetallePedido),dcp.IdDetalleComprobanteProveedor
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN DetalleRecepciones dr ON dr.IdDetalleRecepcion = dcp.IdDetalleRecepcion
 WHERE IsNull(dcp.IdDetallePedido,dr.IdDetallePedido) is not null

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111188133'
SET @vector_T='0D530F06153D20225F55100'

SET NOCOUNT OFF

SELECT 
 DetallePedidos.IdDetallePedido,
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
	IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 Pedidos.FechaPedido as [Fecha pedido],
 Proveedores.RazonSocial as [Proveedor],
 DetallePedidos.NumeroItem as [Item pedido],
 Substring('00000000',1,8-Len(Convert(varchar,Requerimientos.NumeroRequerimiento)))+Convert(varchar,Requerimientos.NumeroRequerimiento) as [Requerimiento],
 DetalleRequerimientos.NumeroItem as [Item RM],
 Requerimientos.FechaRequerimiento as [Fecha requerimiento],
 E1.Nombre as [Solicito requerimiento],
 DetalleRequerimientos.FechaEntrega as [Fecha entrega requerimiento],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Material],
 DetallePedidos.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 E2.Nombre as [Aprobo pedido],
 cc.Descripcion as [Condicion],
 DetallePedidos.FechaEntrega as [Fecha entrega],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 DetallePedidos.Precio*IsNull(Pedidos.CotizacionMoneda,1) as [Precio],
 DetallePedidos.Cantidad*DetallePedidos.Precio*IsNull(Pedidos.CotizacionMoneda,1) as [Importe],
 Monedas.Abreviatura as [Mon.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento = DetallePedidos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetalleRequerimientos.IdRequerimiento
LEFT OUTER JOIN Articulos A1 ON A1.IdArticulo = DetallePedidos.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetallePedidos.IdUnidad
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Pedidos.IdProveedor
LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra = Pedidos.IdCondicionCompra
LEFT OUTER JOIN Obras ON Obras.IdObra = Requerimientos.IdObra
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Pedidos.IdMoneda
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.IdSolicito
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Pedidos.Aprobo
WHERE IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(DetallePedidos.Cumplido,'NO')<>'AN' and 
	Not Exists(Select Top 1 #Auxiliar1.IdDetallePedido From #Auxiliar1 Where #Auxiliar1.IdDetallePedido=DetallePedidos.IdDetallePedido) and 
	IsNull(DetallePedidos.IdDioPorCumplido,0)=0 and IsNull(Pedidos.IdDioPorCumplido,0)=0
ORDER BY [Pedido], [Item pedido]

DROP TABLE #Auxiliar1