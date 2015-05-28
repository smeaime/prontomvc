





























CREATE PROCEDURE [dbo].[SalidasMateriales_TX_TraerVale]
@IdDetalleValeSalida int
as
SELECT
DetVal.IdDetalleValeSalida,
ValesSalida.NumeroValeSalida as [Vale]
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN ValesSalida ON DetVal.IdValeSalida = ValesSalida.IdValeSalida
WHERE (DetVal.IdDetalleValeSalida = @IdDetalleValeSalida)






























