CREATE Procedure [dbo].[ComprobantesProveedores_TX_PorId]

@IdComprobanteProveedor int

AS 

SELECT *
FROM ComprobantesProveedores
WHERE (IdComprobanteProveedor=@IdComprobanteProveedor)