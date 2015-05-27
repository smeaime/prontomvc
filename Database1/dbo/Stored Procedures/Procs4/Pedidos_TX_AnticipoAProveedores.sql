
CREATE Procedure [dbo].[Pedidos_TX_AnticipoAProveedores]

@IdProveedor int = Null

AS 

SET NOCOUNT ON

SET @IdProveedor=IsNull(@IdProveedor,-1)

CREATE TABLE #Auxiliar1 
			(
			 IdPedido INTEGER,
			 IdDetalleComprobanteProveedor INTEGER,
			 PorcentajeCertificacion NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT Pedidos.IdPedido, Null, 0
 FROM Pedidos 
 WHERE (@IdProveedor<=0 or IdProveedor=@IdProveedor) and 
	IsNull(Pedidos.Cumplido,'')<>'AN' 
/*
and Exists(Select Top 1 dcp.IdPedidoAnticipo
		From DetalleComprobantesProveedores dcp 
		Where IsNull(dcp.IdPedidoAnticipo,0)=Pedidos.IdPedido)
*/
UNION ALL

 SELECT dcp.IdPedidoAnticipo, dcp.IdDetalleComprobanteProveedor, IsNull(dcp.PorcentajeCertificacion,0)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = dcp.IdComprobanteProveedor
 WHERE (@IdProveedor<=0 or IdProveedor=@IdProveedor) and 
	dcp.IdPedidoAnticipo is not null and IsNull(cp.Confirmado,'SI')<>'NO'

CREATE TABLE #Auxiliar2 
			(
			 IdPedido INTEGER,
			 PorcentajeCertificacion NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdPedido, Sum(#Auxiliar1.PorcentajeCertificacion)
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.IdPedido
  
SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111188881133'
SET @vector_T='019999999E40344444400'

SELECT 
 #Auxiliar1.IdPedido as [Aux0],
 Case When TiposComprobante.DescripcionAb is null Then 'PE' Else TiposComprobante.DescripcionAb End as [Tipo],
 #Auxiliar1.IdPedido as [Aux1],
 #Auxiliar1.IdDetalleComprobanteProveedor as [Aux2],
 Pedidos.NumeroPedido as [Aux3],
 Case When #Auxiliar1.IdDetalleComprobanteProveedor is null 
	Then 'Z-9999-99999999'
	Else cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)
 End as [Aux4],
 1 as [Aux5],
 Pedidos.IdProveedor as [Aux6],
 Case When #Auxiliar1.IdDetalleComprobanteProveedor is null Then 0 Else 1 End as [Aux7],
 Case When #Auxiliar1.IdDetalleComprobanteProveedor is null 
	Then Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
		Convert(varchar,Pedidos.NumeroPedido)
	Else cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)
 End as [Numero],
 Case When #Auxiliar1.IdDetalleComprobanteProveedor is null 
	Then Pedidos.FechaPedido
	Else cp.FechaComprobante
 End [Fecha],
 Pedidos.Cumplido as [Cump.],
 Proveedores.RazonSocial as [Proveedor],
 Case When #Auxiliar1.IdDetalleComprobanteProveedor is null 
	Then Pedidos.TotalPedido * Pedidos.CotizacionMoneda 
	Else Null
 End as [Total pedido],
 Case When IsNull(dcp.PorcentajeAnticipo,0)<>0 or (dcp.PorcentajeAnticipo is null and dcp.PorcentajeCertificacion is null)
	Then (IsNull(dcp.Importe,0)+IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
		IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
		IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
		IsNull(dcp.ImporteIVA10,0)) * IsNull(cp.CotizacionMoneda,1) * IsNull(TiposComprobante.Coeficiente,1)
	Else Null
 End as [Importe Antic.],
 Case When Not (IsNull(dcp.PorcentajeAnticipo,0)<>0 or (dcp.PorcentajeAnticipo is null and dcp.PorcentajeCertificacion is null))
	Then (IsNull(dcp.Importe,0)+IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
		IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
		IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
		IsNull(dcp.ImporteIVA10,0)) * IsNull(cp.CotizacionMoneda,1) * IsNull(TiposComprobante.Coeficiente,1)
	Else Null
 End as [Importe Certif.],
 dcp.PorcentajeCertificacion as [% Certif.],
 Pedidos.NumeroComparativa as [Comparativa],
 Pedidos.Observaciones as [Observaciones pedido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN DetalleComprobantesProveedores dcp ON #Auxiliar1.IdDetalleComprobanteProveedor=dcp.IdDetalleComprobanteProveedor
LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,Pedidos.IdProveedor)=Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar1.IdPedido=#Auxiliar2.IdPedido
WHERE #Auxiliar2.PorcentajeCertificacion <100

UNION ALL

SELECT 
 #Auxiliar1.IdPedido as [Aux0],
 Null as [Tipo],
 #Auxiliar1.IdPedido as [Aux1],
 Null as [Aux2],
 Pedidos.NumeroPedido as [Aux3],
 'Z-9999-99999999' as [Aux4],
 2 as [Aux5],
 Null as [Aux6],
 9 as [Aux7],
 Null as [Numero],
 Null [Fecha],
 Null as [Cump.],
 Null as [Proveedor],
 Sum(Case When #Auxiliar1.IdDetalleComprobanteProveedor is null Then Pedidos.TotalPedido * Pedidos.CotizacionMoneda Else 0 End) as [Total pedido],
 Sum(Case When IsNull(dcp.PorcentajeAnticipo,0)<>0 or (dcp.PorcentajeAnticipo is null and dcp.PorcentajeCertificacion is null)
	Then (IsNull(dcp.Importe,0)+IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
		IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
		IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
		IsNull(dcp.ImporteIVA10,0)) * IsNull(cp.CotizacionMoneda,1) * IsNull(TiposComprobante.Coeficiente,1)
	Else 0 End) as [Importe Antic.],
 Sum(Case When Not (IsNull(dcp.PorcentajeAnticipo,0)<>0 or (dcp.PorcentajeAnticipo is null and dcp.PorcentajeCertificacion is null))
	Then (IsNull(dcp.Importe,0)+IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+
		IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+IsNull(dcp.ImporteIVA6,0)+
		IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+
		IsNull(dcp.ImporteIVA10,0)) * IsNull(cp.CotizacionMoneda,1) * IsNull(TiposComprobante.Coeficiente,1)
	Else 0 End) as [Importe Certif.],
 Sum(IsNull(dcp.PorcentajeCertificacion,0)) as [% Certif.],
 Null as [Comparativa],
 Null as [Observaciones pedido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN DetalleComprobantesProveedores dcp ON #Auxiliar1.IdDetalleComprobanteProveedor=dcp.IdDetalleComprobanteProveedor
LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar1.IdPedido=#Auxiliar2.IdPedido
WHERE #Auxiliar2.PorcentajeCertificacion <100
GROUP BY #Auxiliar1.IdPedido, Pedidos.NumeroPedido

UNION ALL

SELECT 
 #Auxiliar1.IdPedido as [Aux0],
 Null as [Tipo],
 #Auxiliar1.IdPedido as [Aux1],
 Null as [Aux2],
 Pedidos.NumeroPedido as [Aux3],
 'Z-9999-99999999' as [Aux4],
 3 as [Aux5],
 Null as [Aux6],
 9 as [Aux7],
 Null as [Numero],
 Null [Fecha],
 Null as [Cump.],
 Null as [Proveedor],
 Null as [Total pedido],
 Null as [Importe Antic.],
 Null as [Importe Certif.],
 Null as [% Certif.],
 Null as [Comparativa],
 Null as [Observaciones pedido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Pedidos ON #Auxiliar1.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar1.IdPedido=#Auxiliar2.IdPedido
WHERE #Auxiliar2.PorcentajeCertificacion <100
GROUP BY #Auxiliar1.IdPedido, Pedidos.NumeroPedido

ORDER BY [Aux3], [Aux7], [Aux1], [Aux4], [Aux5]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
