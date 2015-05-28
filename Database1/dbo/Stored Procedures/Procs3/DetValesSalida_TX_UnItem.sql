




CREATE Procedure [dbo].[DetValesSalida_TX_UnItem]
@IdDetalleValeSalida int
AS 
SELECT *
FROM [DetalleValesSalida]
WHERE (IdDetalleValeSalida=@IdDetalleValeSalida)





