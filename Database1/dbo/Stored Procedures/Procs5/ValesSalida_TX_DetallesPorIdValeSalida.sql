
CREATE PROCEDURE [dbo].[ValesSalida_TX_DetallesPorIdValeSalida]
@IdValeSalida int
AS
SELECT * 
FROM DetalleValesSalida DetVal
WHERE (DetVal.IdValeSalida = @IdValeSalida)
