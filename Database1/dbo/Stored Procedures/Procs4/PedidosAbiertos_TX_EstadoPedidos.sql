
CREATE PROCEDURE [dbo].[PedidosAbiertos_TX_EstadoPedidos]

@IdProveedor int = Null

AS

SET NOCOUNT ON

SET @IdProveedor=IsNull(@IdProveedor,-1)

CREATE TABLE #Auxiliar1
			(
			 IdPedidoAbierto INTEGER,
			 IdPedido INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT IdPedidoAbierto, 0
 FROM PedidosAbiertos
 WHERE (@IdProveedor=-1 or @IdProveedor=PedidosAbiertos.IdProveedor)

 UNION ALL

 SELECT Pedidos.IdPedidoAbierto, Pedidos.IdPedido
 FROM Pedidos
 WHERE Pedidos.IdPedidoAbierto is not null and IsNull(Pedidos.Cumplido,'NO')<>'AN' and 
	(@IdProveedor=-1 or @IdProveedor=Pedidos.IdProveedor)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000001111611633'
SET @vector_T='000002G444G4400'

SELECT 
 #Auxiliar1.IdPedidoAbierto as [K_IdPedidoAbierto],
 #Auxiliar1.IdPedido as [K_IdPedido],
 PedidosAbiertos.NumeroPedidoAbierto as [K_NumeroPedidoAbierto],
 Null as [K_NumeroPedido],
 1 as [K_Orden],
 Proveedores.RazonSocial as [Proveedor],
 Substring('00000000',1,8-Len(Convert(varchar,PedidosAbiertos.NumeroPedidoAbierto)))+
	Convert(varchar,PedidosAbiertos.NumeroPedidoAbierto) as [Ped.Ab.],
 PedidosAbiertos.FechaPedidoAbierto as [Fecha],
 PedidosAbiertos.FechaLimite as [Fecha Limite],
 PedidosAbiertos.ImporteLimite as [Importe Limite],
 Null as [Pedido],
 Null as [Fecha pedido],
 Null as [Importe pedido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN PedidosAbiertos ON #Auxiliar1.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN Proveedores ON PedidosAbiertos.IdProveedor = Proveedores.IdProveedor
WHERE #Auxiliar1.IdPedido=0

UNION ALL

SELECT 
 #Auxiliar1.IdPedidoAbierto as [K_IdPedidoAbierto],
 #Auxiliar1.IdPedido as [K_IdPedido],
 PedidosAbiertos.NumeroPedidoAbierto as [K_NumeroPedidoAbierto],
 Pedidos.NumeroPedido as [K_NumeroPedido],
 2 as [K_Orden],
 Null as [Proveedor],
 Null as [Ped.Ab.],
 Null as [Fecha],
 Null as [Fecha Limite],
 Null as [Importe Limite],
 Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
	Convert(varchar,Pedidos.NumeroPedido) as [Pedido],
 Pedidos.FechaPedido as [Fecha pedido],
 Pedidos.TotalPedido as [Importe pedido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN PedidosAbiertos ON #Auxiliar1.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
WHERE #Auxiliar1.IdPedido<>0

UNION ALL

SELECT 
 #Auxiliar1.IdPedidoAbierto as [K_IdPedidoAbierto],
 Null as [K_IdPedido],
 PedidosAbiertos.NumeroPedidoAbierto as [K_NumeroPedidoAbierto],
 Null as [K_NumeroPedido],
 3 as [K_Orden],
 Null as [Proveedor],
 Null as [Ped.Ab.],
 Null as [Fecha],
 Null as [Fecha Limite],
 Null as [Importe Limite],
 'TOTAL' as [Pedido],
 Null as [Fecha pedido],
 Sum(IsNull(Pedidos.TotalPedido,0)) as [Importe pedido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN PedidosAbiertos ON #Auxiliar1.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
GROUP BY #Auxiliar1.IdPedidoAbierto, PedidosAbiertos.NumeroPedidoAbierto

UNION ALL

SELECT 
 #Auxiliar1.IdPedidoAbierto as [K_IdPedidoAbierto],
 Null as [K_IdPedido],
 PedidosAbiertos.NumeroPedidoAbierto as [K_NumeroPedidoAbierto],
 Null as [K_NumeroPedido],
 4 as [K_Orden],
 Null as [Proveedor],
 Null as [Ped.Ab.],
 Null as [Fecha],
 Null as [Fecha Limite],
 Null as [Importe Limite],
 Null as [Pedido],
 Null as [Fecha pedido],
 Null as [Importe pedido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN PedidosAbiertos ON #Auxiliar1.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
GROUP BY #Auxiliar1.IdPedidoAbierto, PedidosAbiertos.NumeroPedidoAbierto

ORDER BY [K_NumeroPedidoAbierto], [K_Orden]

DROP TABLE #Auxiliar1
