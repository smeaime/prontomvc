
CREATE PROCEDURE [dbo].[Recepciones_TX_DetallesParaSalidasDeMateriales]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111133'
SET @vector_T='0E9423D22202033300'

SELECT
 DetRec.IdDetalleRecepcion as [IdDetalleRecepcion],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2) as [Nro.Recepcion],
 DetRec.IdDetalleRecepcion as [IdAux1],
 Recepciones.FechaRecepcion as [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetRec.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 Requerimientos.NumeroRequerimiento as [RM],
 DetReq.NumeroItem as [It.RM],
 Pedidos.NumeroPedido as [Pedido],
 DetPed.NumeroItem as [It.Ped.],
 Obras.NumeroObra as [Obra],
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 DetRec.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetallePedidos DetPed ON DetRec.IdDetallePedido = DetPed.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Unidades ON DetRec.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON DetRec.IdObra = Obras.IdObra
LEFT OUTER JOIN Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE IsNull((Select Sum(IsNull(DetSal.Cantidad,0)) From DetalleSalidasMateriales DetSal Where DetSal.IdDetalleRecepcion=DetRec.IdDetalleRecepcion),0)<DetRec.Cantidad
ORDER BY [Nro.Recepcion], [Fecha]
