CREATE PROCEDURE [dbo].[Recepciones_TX_DetallesResumidos]

@IdRecepcion int

AS

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

SELECT
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Colores.Descripcion as [Color],
 Sum(IsNull(DetRec.Cantidad,0)) as [Cantidad]
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
WHERE (DetRec.IdRecepcion = @IdRecepcion)
GROUP BY Articulos.Codigo, Articulos.Descripcion, Colores.Descripcion
ORDER BY Articulos.Codigo, Articulos.Descripcion, Colores.Descripcion