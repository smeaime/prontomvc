




CREATE Procedure [dbo].[DetFacturasProvincias_E]
@IdDetalleFacturaProvincias int  
AS 
DELETE [DetalleFacturasProvincias]
WHERE (IdDetalleFacturaProvincias=@IdDetalleFacturaProvincias)





