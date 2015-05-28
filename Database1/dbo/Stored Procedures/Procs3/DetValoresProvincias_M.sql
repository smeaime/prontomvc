
CREATE Procedure [dbo].[DetValoresProvincias_M]
@IdDetalleValorProvincias int,
@IdValor int,
@IdProvincia int,
@Porcentaje numeric(6,2)
As
Update DetalleValoresProvincias
Set 
 IdValor=@IdValor,
 IdProvincia=@IdProvincia,
 Porcentaje=@Porcentaje
Where (IdDetalleValorProvincias=@IdDetalleValorProvincias)
Return(@IdDetalleValorProvincias)
