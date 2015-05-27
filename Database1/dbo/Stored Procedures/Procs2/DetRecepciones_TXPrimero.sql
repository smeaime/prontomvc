CREATE PROCEDURE [dbo].[DetRecepciones_TXPrimero]

AS

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0000111111111111111111111111133'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='0000A999999099F9992DGF055994400'
ELSE
	SET @vector_T='0000202099501114222D99055994400'

SELECT Top 1 
 DetRec.IdDetalleRecepcion,
 DetRec.IdRecepcion,
 DetRec.IdDetallePedido,
 DetRec.IdDetalleRequerimiento,
 Pedidos.NumeroPedido as [Pedido],
 DetallePedidos.NumeroItem as [It.Ped],
 Requerimientos.NumeroRequerimiento as [RM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 Acopios.NumeroAcopio as [LA],
 DetalleAcopios.NumeroItem as [It.LA],
 Obras.NumeroObra as [Obra],
 DetRec.Cantidad as [Cant.],
 DetRec.Cantidad1 as [Med.1],
 DetRec.Cantidad2 as [Med.2],
 (Select Unidades.Abreviatura From Unidades Where Unidades.IdUnidad=DetRec.IdUnidad) as  [En],
 (Select Sum(Stock.CantidadUnidades) From Stock Where Stock.IdArticulo=DetRec.IdArticulo)  as [Stock tot.actual],
 Null as [Cant.Orig.],
 Null as [Recibido],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as Articulo,
 DetRec.Talle as [Ta],
 Colores.Descripcion as [Color],
 Substring(ControlesCalidad.Descripcion,1,40) as [Control de Calidad],
 DetRec.Partida,
 DetRec.Trasabilidad,
 DetRec.IdArticulo,
 DetRec.IdUnidad,
 DetRec.Observaciones,
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetRec.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetallePedidos ON DetRec.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleRequerimientos ON DetRec.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleAcopios ON DetRec.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON DetRec.IdObra = Obras.IdObra
LEFT OUTER JOIN Colores ON Colores.IdColor = DetRec.IdColor