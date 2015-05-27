
CREATE Procedure [dbo].[ComprobantesProveedores_TX_ConAnticipoPorIdComprobanteProveedor]

@IdComprobanteProveedor int

AS 

SELECT dcp.*
FROM DetalleComprobantesProveedores dcp 
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = dcp.IdComprobanteProveedor
WHERE dcp.IdComprobanteProveedor=@IdComprobanteProveedor and IsNull(dcp.IdPedidoAnticipo,0)<>0
