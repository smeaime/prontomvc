CREATE Procedure [dbo].[ComprobantesProveedores_TX_AnticiposPorIdPedido]

@IdPedido int

AS 

SELECT SUM(Importe * cp.CotizacionMoneda) as [Importe]
FROM DetalleComprobantesProveedores dcp 
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = dcp.IdComprobanteProveedor
WHERE IsNull(dcp.IdPedidoAnticipo,0)=@IdPedido and IsNull(dcp.PorcentajeAnticipo,0)<>0