



CREATE Procedure [dbo].[ComprobantesProveedores_TX_VerificarProveedor]
@IdProveedor int
AS 
SELECT TOP 1
 cp.IdComprobanteProveedor
FROM ComprobantesProveedores cp
WHERE IsNull(cp.IdProveedor,-1)=@IdProveedor or 
	IsNull(cp.IdProveedorEventual,-1)=@IdProveedor



