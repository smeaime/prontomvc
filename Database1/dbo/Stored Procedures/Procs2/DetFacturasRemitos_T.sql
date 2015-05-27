






























CREATE Procedure [dbo].[DetFacturasRemitos_T]
@IdDetalleFacturaRemitos int
AS 
SELECT *
FROM DetalleFacturasRemitos
WHERE (IdDetalleFacturaRemitos=@IdDetalleFacturaRemitos)































