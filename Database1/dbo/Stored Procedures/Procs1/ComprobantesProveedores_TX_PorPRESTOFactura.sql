






CREATE Procedure [dbo].[ComprobantesProveedores_TX_PorPRESTOFactura]
@PRESTOFactura varchar(13),
@PRESTOProveedor varchar(13)
AS 
SELECT 
 cp.IdComprobanteProveedor
FROM ComprobantesProveedores cp 
WHERE cp.PRESTOFactura=@PRESTOFactura and 
	PRESTOProveedor=@PRESTOProveedor






