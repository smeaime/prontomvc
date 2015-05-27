




CREATE Procedure [dbo].[DetNotasDebitoProvincias_M]
@IdDetalleNotaDebitoProvincias int,
@IdNotaDebito int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2)
AS
UPDATE [DetalleNotasDebitoProvincias]
SET 
 IdNotaDebito=@IdNotaDebito,
 IdProvinciaDestino=@IdProvinciaDestino,
 Porcentaje=@Porcentaje
WHERE (IdDetalleNotaDebitoProvincias=@IdDetalleNotaDebitoProvincias)
RETURN(@IdDetalleNotaDebitoProvincias)




