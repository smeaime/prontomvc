




CREATE Procedure [dbo].[Pedidos_TX_ParaPasarAPrestoDetalles]
AS 
SELECT
 DetPed.IdDetallePedido,
 Case 	When Pedidos.SubNumero is not null 
	Then LTrim(Str(Pedidos.NumeroPedido,8))+'/'+LTrim(Str(Pedidos.SubNumero,4))
	Else LTrim(Str(Pedidos.NumeroPedido,8))
 End as [Pedido],
 Pedidos.FechaPedido [Fecha],
 Requerimientos.PRESTOContrato,
 Articulos.Codigo,
 Case When DetPed.PorcentajeBonificacion is not null 
	Then DetPed.Precio-(DetPed.Precio*DetPed.PorcentajeBonificacion/100)
	Else DetPed.Precio
 End as [Precio],
 DetPed.Cantidad,
 DetPed.FechaEntrega,
 Proveedores.CodigoPresto as [ProveedorPresto],
 DetReq.PRESTOConcepto,
 Obras.NumeroObra
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetPed.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
WHERE (DetPed.Cumplido is null or DetPed.Cumplido<>'AN') and 
	(Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and 
	(DetPed.PRESTOPedido is null and Requerimientos.PRESTOContrato is not null)




