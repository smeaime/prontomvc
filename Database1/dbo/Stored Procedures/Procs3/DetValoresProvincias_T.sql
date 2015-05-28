
CREATE Procedure [dbo].[DetValoresProvincias_T]
@IdDetalleValorProvincias int
AS 
SELECT *
FROM DetalleValoresProvincias
WHERE (IdDetalleValorProvincias=@IdDetalleValorProvincias)
