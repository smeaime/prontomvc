
CREATE Procedure [dbo].[wComprobantesProveedores_TX_UltimoComprobantePorIdProveedor]
@IdProveedor int
AS
SELECT TOP 1 *
FROM ComprobantesProveedores cp
WHERE cp.IdProveedor=@IdProveedor or cp.IdProveedorEventual=@IdProveedor
ORDER BY cp.FechaComprobante DESC,cp.NumeroComprobante2 DESC

