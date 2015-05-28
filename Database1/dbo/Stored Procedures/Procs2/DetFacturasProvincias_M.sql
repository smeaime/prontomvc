


CREATE Procedure [dbo].[DetFacturasProvincias_M]
@IdDetalleFacturaProvincias int,
@IdFactura int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2),
@EnviarEmail tinyint = null
AS
UPDATE [DetalleFacturasProvincias]
SET 
 IdFactura=@IdFactura,
 IdProvinciaDestino=@IdProvinciaDestino,
 Porcentaje=@Porcentaje,
 EnviarEmail=@EnviarEmail
WHERE (IdDetalleFacturaProvincias=@IdDetalleFacturaProvincias)
RETURN(@IdDetalleFacturaProvincias)


