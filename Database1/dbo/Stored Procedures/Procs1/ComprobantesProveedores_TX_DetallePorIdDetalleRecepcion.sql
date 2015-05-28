
CREATE PROCEDURE [dbo].[ComprobantesProveedores_TX_DetallePorIdDetalleRecepcion]

@IdDetalleRecepcion int

AS

SELECT
 DetCP.IdDetalleComprobanteProveedor,
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2),1,20) as [Comprobante],
 cp.FechaComprobante as [Fecha],
 Articulos.Codigo as [CodigoArticulo]
FROM DetalleComprobantesProveedores DetCP
LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
LEFT OUTER JOIN DetalleRecepciones DetRec ON DetCP.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Articulos ON DetRec.IdArticulo = Articulos.IdArticulo
WHERE DetCP.IdDetalleRecepcion = @IdDetalleRecepcion
