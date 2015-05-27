
CREATE Procedure [dbo].[ComprobantesProveedores_TX_PorNumeroReferencia]

@NumeroReferencia int,
@IdProveedor int = Null


AS

SET @IdProveedor=IsNull(@IdProveedor,-1)

SELECT 
 cp.IdComprobanteProveedor,
 cp.FechaComprobante,
 cp.IdProveedor
FROM ComprobantesProveedores cp
WHERE cp.NumeroReferencia=@NumeroReferencia and (@IdProveedor=-1 or IdProveedor=@IdProveedor)
