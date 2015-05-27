
CREATE PROCEDURE [dbo].[DetRecepciones_TX_DetallesParametrizados]

@IdRecepcion int,
@NivelParametrizacion int

AS

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='00001111111111111111111111133'
	Set @vector_T='0000202099509914222D955994400'
   END
ELSE
   BEGIN
	Set @vector_X='00001111111111111111111111133'
	Set @vector_T='0000202099501114222D055994400'
   END

SELECT
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
 (Select Unidades.Abreviatura
	From Unidades
	Where Unidades.IdUnidad=DetRec.IdUnidad) as  [En],
 (Select Sum(Stock.CantidadUnidades) 
	From Stock 
	Where Stock.IdArticulo=DetRec.IdArticulo)  as [Stock tot.actual],
 Case 	When DetRec.IdDetallePedido is not null
	 Then DetallePedidos.Cantidad
 	When DetRec.IdDetalleRequerimiento is not null
	 Then DetalleRequerimientos.Cantidad
 	When DetRec.IdDetalleAcopios is not null
	 Then DetalleAcopios.Cantidad
	Else Null
 End as [Cant.Orig.],
 Case 	When DetRec.IdDetallePedido is not null
	 Then (Select Sum(DetalleRecepciones.Cantidad) 
		From DetalleRecepciones 
		Where DetalleRecepciones.IdDetallePedido=DetRec.IdDetallePedido)
 	When DetRec.IdDetalleRequerimiento is not null
	 Then (Select Sum(DetalleRecepciones.Cantidad) 
		From DetalleRecepciones 
		Where DetalleRecepciones.IdDetalleRequerimiento=DetRec.IdDetalleRequerimiento)
 	When DetRec.IdDetalleAcopios is not null
	 Then (Select Sum(DetalleRecepciones.Cantidad) 
		From DetalleRecepciones 
		Where DetalleRecepciones.IdDetalleAcopios=DetRec.IdDetalleAcopios)
 End as [Recibido],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
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
WHERE (DetRec.IdRecepcion = @IdRecepcion)
ORDER by Pedidos.NumeroPedido,DetallePedidos.NumeroItem
