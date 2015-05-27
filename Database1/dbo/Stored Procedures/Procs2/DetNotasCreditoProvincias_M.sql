




CREATE Procedure [dbo].[DetNotasCreditoProvincias_M]
@IdDetalleNotaCreditoProvincias int,
@IdNotaCredito int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2)
AS
UPDATE [DetalleNotasCreditoProvincias]
SET 
 IdNotaCredito=@IdNotaCredito,
 IdProvinciaDestino=@IdProvinciaDestino,
 Porcentaje=@Porcentaje
WHERE (IdDetalleNotaCreditoProvincias=@IdDetalleNotaCreditoProvincias)
RETURN(@IdDetalleNotaCreditoProvincias)




