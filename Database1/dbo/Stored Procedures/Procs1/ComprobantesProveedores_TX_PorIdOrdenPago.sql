CREATE Procedure [dbo].[ComprobantesProveedores_TX_PorIdOrdenPago]

@IdOrdenPago int,
@IdOrdenPagoRetencionIva int = Null

AS 

SET @IdOrdenPagoRetencionIva=IsNull(@IdOrdenPagoRetencionIva,0)

SELECT 
 cp.IdComprobanteProveedor, 
 cp.TotalComprobante*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente) as [TotalComprobante],
 cp.TotalComprobante*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1) as [TotalComprobante_1],
 cp.TotalIva1*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1) as [TotalIva1_1],
 tc.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante_1]
FROM ComprobantesProveedores cp
LEFT OUTER JOIN TiposComprobante tc ON  cp.IdTipoComprobante = tc.IdTipoComprobante
WHERE IdOrdenPago=@IdOrdenPago

UNION ALL

SELECT 
 cp.IdComprobanteProveedor, 
 cp.TotalComprobante*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente) as [TotalComprobante],
 cp.TotalComprobante*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1) as [TotalComprobante_1],
 cp.TotalIva1*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1) as [TotalIva1_1],
 tc.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante_1]
FROM ComprobantesProveedores cp
LEFT OUTER JOIN TiposComprobante tc ON  cp.IdTipoComprobante = tc.IdTipoComprobante
WHERE IsNull(IdOrdenPagoRetencionIva,-1)=@IdOrdenPagoRetencionIva