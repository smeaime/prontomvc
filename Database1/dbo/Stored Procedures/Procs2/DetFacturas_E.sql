CREATE Procedure [dbo].[DetFacturas_E]

@IdDetalleFacturas int

AS 

DELETE DetalleFacturas
WHERE (IdDetalleFactura=@IdDetalleFacturas)