
CREATE PROCEDURE [dbo].[DetValoresProvincias_TX_PorIdValor]
@IdValor int
AS
SELECT DetalleValoresProvincias.*, Provincias.Nombre as [Provincia]
FROM DetalleValoresProvincias 
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=DetalleValoresProvincias.IdProvincia
WHERE (DetalleValoresProvincias.IdValor = @IdValor)
