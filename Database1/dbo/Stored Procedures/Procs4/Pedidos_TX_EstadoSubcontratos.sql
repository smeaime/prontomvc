
CREATE Procedure [dbo].[Pedidos_TX_EstadoSubcontratos]

@IdProveedor int,
@IdPedido int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdPedido INTEGER,
			 TotalPedido NUMERIC(18,2),
			 IdComprobanteProveedor INTEGER,
			 FondoReparo NUMERIC(18,2),
			 TotalComprobante NUMERIC(18,2),
			 NumeroOrdenPagoFondoReparo INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Pedidos.IdPedido,
  Pedidos.TotalPedido * Pedidos.CotizacionMoneda,
  Null,
  0,
  0,
  0
 FROM Pedidos
 WHERE IsNull(Pedidos.Subcontrato,'NO')='SI' and 
	(@IdProveedor=-1 or @IdProveedor=Pedidos.IdProveedor) and 
	(@IdPedido=-1 or @IdPedido=Pedidos.IdPedido)

 UNION ALL

 SELECT 
  dcp.IdPedido,
  0,
  cp.IdComprobanteProveedor,
  IsNull(cp.FondoReparo,0),
  (dcp.Importe + IsNull(dcp.ImporteIVA1,0) + IsNull(dcp.ImporteIVA2,0) + 
	IsNull(dcp.ImporteIVA3,0) + IsNull(dcp.ImporteIVA4,0) + 
	IsNull(dcp.ImporteIVA5,0) + IsNull(dcp.ImporteIVA6,0) + 
	IsNull(dcp.ImporteIVA7,0) + IsNull(dcp.ImporteIVA8,0) + 
	IsNull(dcp.ImporteIVA9,0) + IsNull(dcp.ImporteIVA10,0)) * 
	cp.CotizacionMoneda * TiposComprobante.Coeficiente,
  IsNull(cp.NumeroOrdenPagoFondoReparo,0)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN Pedidos ON dcp.IdPedido=Pedidos.IdPedido
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE dcp.IdPedido is not null and IsNull(Pedidos.Subcontrato,'NO')='SI' and 
	(@IdProveedor=-1 or @IdProveedor=Pedidos.IdProveedor) and 
	(@IdPedido=-1 or @IdPedido=Pedidos.IdPedido)


SET NOCOUNT OFF

SELECT 
 #Auxiliar1.IdPedido as [K_IdPedido],
 Pedidos.FechaPedido as [K_FechaPedido],
 1 as [K_Orden],
 Null as [K_FechaComprobante],
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+ltrim(str(Pedidos.SubNumero,4))
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 Pedidos.FechaPedido as [Fecha subcontrato],
 Proveedores.RazonSocial as [Proveedor],
 SUM(#Auxiliar1.TotalPedido) as [Total subcontrato],
 Null as [Comprobante],
 Null as [Fecha comp.],
 Null as [Total comp.],
 Null as [Diferencia],
 Null as [Fondo reparo],
 Null as [NumeroOrdenPagoFondoReparo]
FROM #Auxiliar1
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
GROUP BY #Auxiliar1.IdPedido,Pedidos.NumeroPedido,Pedidos.SubNumero,
	Pedidos.FechaPedido,Proveedores.RazonSocial

UNION ALL

SELECT 
 #Auxiliar1.IdPedido as [K_IdPedido],
 Pedidos.FechaPedido as [K_FechaPedido],
 2 as [K_Orden],
 cp.FechaRecepcion as [K_FechaComprobante],
 Null as [Pedido],
 Null as [Fecha subcontrato],
 Null as [Proveedor],
 Null as [Total subcontrato],
 TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 cp.FechaRecepcion as [Fecha comp.],
 SUM(#Auxiliar1.TotalComprobante) as [Total comp.],
 Null as [Diferencia],
 MAX(#Auxiliar1.FondoReparo) as [Fondo reparo],
 MAX(#Auxiliar1.NumeroOrdenPagoFondoReparo) as [NumeroOrdenPagoFondoReparo]
FROM #Auxiliar1
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN ComprobantesProveedores cp ON #Auxiliar1.IdComprobanteProveedor=cp.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
WHERE #Auxiliar1.IdComprobanteProveedor is not null
GROUP BY #Auxiliar1.IdPedido,Pedidos.FechaPedido,cp.FechaRecepcion,TiposComprobante.DescripcionAb,
	cp.Letra,cp.NumeroComprobante1,cp.NumeroComprobante2

UNION ALL

SELECT 
 #Auxiliar1.IdPedido as [K_IdPedido],
 Pedidos.FechaPedido as [K_FechaPedido],
 3 as [K_Orden],
 Null as [K_FechaComprobante],
 Null as [Pedido],
 Null as [Fecha subcontrato],
 'TOTAL SUBCONTRATO' as [Proveedor],
 SUM(#Auxiliar1.TotalPedido) as [Total subcontrato],
 Null as [Comprobante],
 Null as [Fecha comp.],
 SUM(#Auxiliar1.TotalComprobante) as [Total comp.],
 SUM(#Auxiliar1.TotalPedido)-SUM(#Auxiliar1.TotalComprobante) as [Diferencia],
 Null as [Fondo reparo],
 Null as [NumeroOrdenPagoFondoReparo]
FROM #Auxiliar1
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
GROUP BY #Auxiliar1.IdPedido,Pedidos.NumeroPedido,Pedidos.SubNumero,Pedidos.FechaPedido

UNION ALL

SELECT 
 #Auxiliar1.IdPedido as [K_IdPedido],
 Pedidos.FechaPedido as [K_FechaPedido],
 4 as [K_Orden],
 Null as [K_FechaComprobante],
 Null as [Pedido],
 Null as [Fecha subcontrato],
 Null as [Proveedor],
 Null as [Total subcontrato],
 Null as [Comprobante],
 Null as [Fecha comp.],
 Null as [Total comp.],
 Null as [Diferencia],
 Null as [Fondo reparo],
 Null as [NumeroOrdenPagoFondoReparo]
FROM #Auxiliar1
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
GROUP BY #Auxiliar1.IdPedido,Pedidos.NumeroPedido,Pedidos.SubNumero,Pedidos.FechaPedido

ORDER BY [K_IdPedido],[K_FechaPedido],[K_Orden],[K_FechaComprobante]

DROP TABLE #Auxiliar1
