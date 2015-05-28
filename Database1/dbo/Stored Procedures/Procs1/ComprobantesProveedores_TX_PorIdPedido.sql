CREATE PROCEDURE [dbo].[ComprobantesProveedores_TX_PorIdPedido]

@IdPedido int

AS

SELECT DISTINCT 
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Comprobante],
 cp.FechaComprobante as [Fecha]
FROM DetalleComprobantesProveedores DetCP
LEFT OUTER JOIN ComprobantesProveedores cp ON DetCP.IdComprobanteProveedor = cp.IdComprobanteProveedor
LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido = DetCP.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
WHERE DetallePedidos.IdPedido = @IdPedido
