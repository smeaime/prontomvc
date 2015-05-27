
CREATE Procedure [dbo].[Subcontratos_TX_EtapasConConsumos]

@NumeroSubcontrato int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 (IdSubcontrato INTEGER)
INSERT INTO #Auxiliar0 
 SELECT IdSubcontrato
 FROM Subcontratos
 WHERE NumeroSubcontrato=@NumeroSubcontrato

SET NOCOUNT OFF

SELECT 
 IdSubcontrato as [IdSubcontrato], 
 Item as [Item], 
 Descripcion as [Detalle], 
 Null as [Tipo comp.], 
 Null as [Nro.Ref.], 
 Null as [Comprobante], 
 Null as [Tipo], 
 Null as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 Null as [Iva], 
 Null as [Importe]
FROM Subcontratos
WHERE NumeroSubcontrato=@NumeroSubcontrato

UNION ALL

SELECT 
 Det.IdSubcontrato as [IdSubcontrato], 
 Subcontratos.Item as [Item], 
 Null as [Detalle], 
 TiposComprobante.Descripcion as [Tipo comp.], 
 cp.NumeroReferencia as [Nro.Ref.], 
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante], 
 Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
	When cp.IdCuenta is not null Then 'F.fijo' 
	When cp.IdCuentaOtros is not null Then 'Otros' 
	Else Null
 End as [Tipo], 
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha rec.], 
 IsNull(P1.RazonSocial,IsNull(P2.RazonSocial,C1.Descripcion)) as [Proveedor / Cuenta], 
 IsNull(Det.ImporteIVA1,0) + IsNull(Det.ImporteIVA2,0) + IsNull(Det.ImporteIVA3,0) + 
	IsNull(Det.ImporteIVA4,0) + IsNull(Det.ImporteIVA5,0) + IsNull(Det.ImporteIVA6,0) + 
	IsNull(Det.ImporteIVA7,0) + IsNull(Det.ImporteIVA8,0) + IsNull(Det.ImporteIVA9,0) + 
	IsNull(Det.ImporteIVA10,0) as [Iva], 
 Det.Importe as [Importe]
FROM DetalleComprobantesProveedores Det 
LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores P1 ON cp.IdProveedor = P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor
LEFT OUTER JOIN Cuentas C1 ON IsNull(cp.IdCuenta,cp.IdCuentaOtros) = C1.IdCuenta
LEFT OUTER JOIN Cuentas C2 ON Det.IdCuenta = C2.IdCuenta
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN DescripcionIva diva1 ON cp.IdCodigoIva = diva1.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva2 ON P1.IdCodigoIva = diva2.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva3 ON P2.IdCodigoIva = diva3.IdCodigoIva
LEFT OUTER JOIN DetalleRecepciones DetRec ON DetRec.IdDetalleRecepcion=Det.IdDetalleRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=Det.IdDetallePedido
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento=IsNull(DetRec.IdDetalleRequerimiento,DetPed.IdDetalleRequerimiento)
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar0 ON Det.IdSubcontrato = #Auxiliar0.IdSubcontrato
LEFT OUTER JOIN Subcontratos ON Det.IdSubcontrato = Subcontratos.IdSubcontrato
WHERE IsNull(Det.IdSubcontrato,0) In (Select IdSubcontrato From #Auxiliar0) 

ORDER BY [IdSubcontrato], [Item]

DROP TABLE #Auxiliar0
