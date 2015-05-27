CREATE Procedure [dbo].[ComprobantesProveedores_TX_ConRetencionIvaPorIdOrdenPago]

@IdOrdenPagoRetencionIva int

AS 

SELECT 
 tc.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 cp.FechaRecepcion as [Fecha],
 IsNull(cp.TotalBruto,0)*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1) as [ImporteBruto],
 IsNull(cp.TotalIva1,0)*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1) as [ImporteIva],
 IsNull(cp.TotalComprobante,0)*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1) as [TotalComprobante],
 cp.ImporteRetencionIvaEnOrdenPago
FROM ComprobantesProveedores cp 
LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
WHERE cp.IdOrdenPagoRetencionIva=@IdOrdenPagoRetencionIva