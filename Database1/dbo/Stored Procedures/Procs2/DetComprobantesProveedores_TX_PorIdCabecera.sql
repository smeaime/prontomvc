
CREATE PROCEDURE [dbo].[DetComprobantesProveedores_TX_PorIdCabecera]
@IdComprobanteProveedor int
AS
SELECT *
FROM DetalleComprobantesProveedores DetCom
WHERE DetCom.IdComprobanteProveedor = @IdComprobanteProveedor
