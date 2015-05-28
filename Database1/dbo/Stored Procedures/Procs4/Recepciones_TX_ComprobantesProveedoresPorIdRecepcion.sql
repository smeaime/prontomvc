




CREATE PROCEDURE [dbo].[Recepciones_TX_ComprobantesProveedoresPorIdRecepcion]

@IdRecepcion int

AS

SELECT DISTINCT
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2),1,20) as [Comprobante],
 cp.FechaComprobante
FROM Recepciones
LEFT OUTER JOIN DetalleRecepciones DetRec ON Recepciones.IdRecepcion = DetRec.IdRecepcion
INNER JOIN DetalleComprobantesProveedores DetCP ON DetRec.IdDetalleRecepcion = DetCP.IdDetalleRecepcion
LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
WHERE DetRec.IdRecepcion=@IdRecepcion and IsNull(Recepciones.Anulada,'NO')<>'SI'




