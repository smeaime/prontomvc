




CREATE Procedure [dbo].[DetFacturasProvincias_T]
@IdDetalleFacturaProvincias int
AS 
SELECT *
FROM [DetalleFacturasProvincias]
WHERE (IdDetalleFacturaProvincias=@IdDetalleFacturaProvincias)





