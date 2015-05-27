
CREATE Procedure [dbo].[DetValoresProvincias_A]
@IdDetalleValorProvincias int  output,
@IdValor int,
@IdProvincia int,
@Porcentaje numeric(6,2)
As 
Insert into [DetalleValoresProvincias]
(
 IdValor,
 IdProvincia,
 Porcentaje
)
Values
(
 @IdValor,
 @IdProvincia,
 @Porcentaje
)
Select @IdDetalleValorProvincias=@@identity
Return(@IdDetalleValorProvincias)
