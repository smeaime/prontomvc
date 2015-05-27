CREATE Procedure [dbo].[Facturas_EliminarFacturaAnulada]

@IdFactura int

AS

DELETE FROM DetalleFacturas
WHERE IdFactura=@IdFactura

DELETE FROM DetalleFacturasRemitos
WHERE IdFactura=@IdFactura

DELETE FROM DetalleFacturasOrdenesCompra
WHERE IdFactura=@IdFactura

DELETE FROM Facturas
WHERE IdFactura=@IdFactura