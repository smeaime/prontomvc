
















CREATE PROCEDURE [dbo].[Pedidos_TX_ComprasTercerosDetalladas]
@Desde datetime,
@Hasta datetime
AS
SELECT
CASE 
	WHEN Acopios.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
	WHEN Requerimientos.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
	ELSE null
END as [Obra],
CASE 
	WHEN Acopios.IdObra IS NOT NULL THEN (	Select Clientes.RazonSocial 
						From Obras 
						LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
						Where Acopios.IdObra=Obras.IdObra )
	WHEN Requerimientos.IdObra IS NOT NULL THEN (	Select Clientes.RazonSocial 
						From Obras 
						LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
						Where Requerimientos.IdObra=Obras.IdObra )
	ELSE null
END as [Cliente],
Null as [Destino],
Pedidos.NumeroPedido as [Nro.Pedido],
Proveedores.RazonSocial as [Proveedor],
(DetPed.Cantidad*DetPed.Precio) as [Importe]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE 
Pedidos.FechaPedido Between @Desde and @Hasta AND 
(Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') AND 
(DetPed.Cumplido is null or DetPed.Cumplido<>'AN') AND 
Pedidos.TipoCompra=2 AND 
(
	SUBSTRING((CASE 
			WHEN Acopios.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			WHEN Requerimientos.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			ELSE null
		   END),1,3)='OBT'
	OR
	SUBSTRING((CASE 
			WHEN Acopios.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Acopios.IdObra=Obras.IdObra)
			WHEN Requerimientos.IdObra IS NOT NULL THEN (Select Obras.NumeroObra From Obras Where Requerimientos.IdObra=Obras.IdObra)
			ELSE null
		 END),1,3)='OBM'
)
ORDER BY [Obra],[Cliente]

















