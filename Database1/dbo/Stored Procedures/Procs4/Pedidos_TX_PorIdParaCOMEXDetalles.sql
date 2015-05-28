


CREATE  Procedure [dbo].[Pedidos_TX_PorIdParaCOMEXDetalles]

@IdPedido int

AS 

SELECT 
 DetPed.IdDetallePedido,
 DetPed.IdPedido,
 DetPed.NumeroItem as [Item],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Descripcion],
 DetPed.Cantidad as [Cantidad],
 (Select IsNull(Unidades.Abreviatura,Unidades.Descripcion)
	From Unidades
	Where Unidades.IdUnidad=DetPed.IdUnidad) as [Unidad],
 DetPed.Precio as [Precio],
 DetPed.Observaciones as [Observaciones],
 IsNull(Monedas.Abreviatura,Monedas.Nombre) as [Moneda]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
WHERE (DetPed.IdPedido = @IdPedido)
ORDER BY DetPed.NumeroItem


