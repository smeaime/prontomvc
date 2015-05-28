
CREATE PROCEDURE [dbo].[Pedidos_TX_PorArticuloRubro]

@Desde datetime,
@Hasta datetime,
@IdArticulo int,
@IdRubro int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111133'
SET @vector_T='019D141G4400'

SELECT 
 DetPed.IdDetallePedido,
 Proveedores.RazonSocial as [Proveedor],
 Pedidos.IdProveedor,
 Articulos.Descripcion as [Articulo],
 Pedidos.NumeroPedido as [Pedido],
 Pedidos.FechaPedido as [Fecha],
 DetPed.Cantidad as [Cant.],
 Monedas.Abreviatura as [Mon.],
 (DetPed.Precio-(DetPed.Precio*IsNull(DetPed.PorcentajeBonificacion,0)/100)) as [Precio],
 DetPed.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetPed.IdPedido
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetPed.IdArticulo
LEFT OUTER JOIN Rubros ON Rubros.IdRubro=Articulos.IdRubro
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Pedidos.IdProveedor
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Pedidos.IdMoneda
WHERE (Pedidos.FechaPedido>=@Desde and Pedidos.FechaPedido<=@Hasta) and 
	IsNull(Pedidos.Cumplido,'')<>'AN' and IsNull(DetPed.Cumplido,'')<>'AN' and 
	(@IdArticulo=-1 or DetPed.IdArticulo=@IdArticulo) and 
	(@IdRubro=-1 or Articulos.IdRubro=@IdRubro)  
ORDER BY Proveedores.RazonSocial, Pedidos.FechaPedido desc, Pedidos.NumeroPedido desc
