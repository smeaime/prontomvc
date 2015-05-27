CREATE PROCEDURE [dbo].[ComprobantesProveedores_TX_DetallePorIdCabecera]

@IdComprobanteProveedor int

AS

SELECT DetCP.*
FROM DetalleComprobantesProveedores DetCP
WHERE DetCP.IdComprobanteProveedor = @IdComprobanteProveedor