




CREATE Procedure [dbo].[DetNotasDebitoProvincias_T]
@IdDetalleNotaDebitoProvincias int
AS 
SELECT *
FROM [DetalleNotasDebitoProvincias]
WHERE (IdDetalleNotaDebitoProvincias=@IdDetalleNotaDebitoProvincias)





