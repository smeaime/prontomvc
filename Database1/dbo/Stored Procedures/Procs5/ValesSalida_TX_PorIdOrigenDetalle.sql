




CREATE Procedure [dbo].[ValesSalida_TX_PorIdOrigenDetalle]
@IdDetalleValeSalidaOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 
 dvs.IdDetalleValeSalida,
 ValesSalida.IdValeSalida
FROM DetalleValesSalida dvs
LEFT OUTER JOIN ValesSalida ON dvs.IdValeSalida=ValesSalida.IdValeSalida
WHERE dvs.IdDetalleValeSalidaOriginal=@IdDetalleValeSalidaOriginal and 
	dvs.IdOrigenTransmision=@IdOrigenTransmision




