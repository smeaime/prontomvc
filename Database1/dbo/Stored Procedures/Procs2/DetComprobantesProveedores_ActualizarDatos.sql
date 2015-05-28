CREATE Procedure [dbo].[DetComprobantesProveedores_ActualizarDatos]

@IdDetalleComprobanteProveedor int,
@IdRubroContable int

AS

UPDATE DetalleComprobantesProveedores
SET IdRubroContable=@IdRubroContable
WHERE (IdDetalleComprobanteProveedor=@IdDetalleComprobanteProveedor)