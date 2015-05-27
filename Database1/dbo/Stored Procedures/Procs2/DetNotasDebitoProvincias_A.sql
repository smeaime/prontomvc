



CREATE Procedure [dbo].[DetNotasDebitoProvincias_A]
@IdDetalleNotaDebitoProvincias int output,
@IdNotaDebito int,
@IdProvinciaDestino int,
@Porcentaje numeric(6,2)
As 
Insert into [DetalleNotasDebitoProvincias]
(
 IdNotaDebito,
 IdProvinciaDestino,
 Porcentaje
)
Values
(
 @IdNotaDebito,
 @IdProvinciaDestino,
 @Porcentaje
)
Select @IdDetalleNotaDebitoProvincias=@@identity
Return(@IdDetalleNotaDebitoProvincias)




