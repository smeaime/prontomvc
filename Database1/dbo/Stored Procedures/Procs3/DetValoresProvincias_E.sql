
CREATE Procedure [dbo].[DetValoresProvincias_E]
@IdDetalleValorProvincias int
As 
Delete DetalleValoresProvincias
Where (IdDetalleValorProvincias=@IdDetalleValorProvincias)

