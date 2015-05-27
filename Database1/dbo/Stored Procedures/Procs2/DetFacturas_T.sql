CREATE Procedure [dbo].[DetFacturas_T]

@IdDetalleFactura int

AS 

SELECT *
FROM DetalleFacturas
WHERE (IdDetalleFactura=@IdDetalleFactura)