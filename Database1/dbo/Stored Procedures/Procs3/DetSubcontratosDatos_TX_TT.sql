
CREATE PROCEDURE [dbo].[DetSubcontratosDatos_TX_TT]

@IdSubcontratoDatos int

AS

SELECT *
FROM DetalleSubcontratosDatos Det
WHERE Det.IdSubcontratoDatos = @IdSubcontratoDatos
ORDER BY Det.NumeroCertificado
