CREATE Procedure [dbo].[ComprobantesProveedores_GrabarVale]

@IdComprobanteProveedor int,
@IdOrdenPago int

AS

UPDATE ComprobantesProveedores
SET IdOrdenPago=@IdOrdenPago
WHERE IdComprobanteProveedor=@IdComprobanteProveedor