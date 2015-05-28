




CREATE Procedure [dbo].[Pedidos_TX_ParaPasarAPrestoCabeceras]
AS 
SELECT
 DetPed.IdPedido,
 Case 	When Pedidos.SubNumero is not null 
	Then LTrim(Str(Pedidos.NumeroPedido,8))+'/'+LTrim(Str(Pedidos.SubNumero,4))
	Else LTrim(Str(Pedidos.NumeroPedido,8))
 End as [Pedido],
 Pedidos.FechaPedido [Fecha],
 Requerimientos.PRESTOContrato,
 Proveedores.CodigoPresto as [ProveedorPresto],
 Sum(Case When DetPed.PorcentajeBonificacion is not null 
		Then DetPed.Precio-(DetPed.Precio*DetPed.PorcentajeBonificacion/100)
		Else DetPed.Precio
	 End * DetPed.Cantidad) as [ImportePedido]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetPed.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (DetPed.Cumplido is null or DetPed.Cumplido<>'AN') and 
	(Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and 
	(Pedidos.PRESTOPedido is null and Requerimientos.PRESTOContrato is not null)
GROUP BY DetPed.IdPedido,Pedidos.NumeroPedido,Pedidos.SubNumero,Pedidos.FechaPedido,
	 Requerimientos.PRESTOContrato,Proveedores.CodigoPresto




